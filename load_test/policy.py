from locust import task, TaskSet, HttpUser, constant
import json
from faker import Faker
from random import choice
import environmentVariable

fake = Faker()

ec2_instance_ip = environmentVariable.host

f = open("user_Credentials.json", "r")
data = list(json.load(f))

insuranceType = ["Health Insurance", "Car Insurance", "Life Insurance", "Home Insurance"]
deductibleAmount = [300, 500, 1000, 1500, 2000, 2500]


class loginWithDifferentAccount(TaskSet):
    email = "NOT_FOUND"
    password = "NOT_FOUND"
    firstname = "NOT_FOUND"
    lastname = "NOT_FOUND"
    streetAddress = "NOT_FOUND"
    postalCode = "NOT_FOUND"
    city = "NOT_FOUND"
    phoneNumber = "NOT_FOUND"
    birthday = "NOT_FOUND"
    value = "NOT FOUND"
    x_Auth_token = "NOT_FOUND"
    customer_ID = "NOT_FOUND"

    @task
    def on_start(self):
        random_user = choice(data)
        self.email = random_user["email"]
        self.password = random_user["password"]
        self.firstname = random_user["firstname"]
        self.lastname = random_user["lastname"]
        self.streetAddress = random_user["streetAddress"]
        self.postalCode = random_user["postalCode"]
        self.city = random_user["city"]
        self.phoneNumber = random_user["phoneNumber"]
        self.birthday = random_user["birthday"]

        res = self.client.post(":8080/auth", json={"email": random_user["email"], "password": random_user["password"]},
                               catch_response=True)

        self.x_Auth_token = json.loads(res.text)['token']
        headers = {"X-Auth-Token": self.x_Auth_token}
        res2 = self.client.get(":8080/user", headers=headers, catch_response=True)
        print("--------------------------------------------------")
        print(f"Logging with email {self.email}")
        self.customer_ID = json.loads(res2.text)["customerId"]

    @task
    def policies(self):
        res = self.client.get(":8090/customers/" + self.customer_ID + "/policies")
        print("--------------------------------------------------")
        print(f"Showing policy of {self.firstname} {self.lastname} with email {self.email}\n", res.text)

    @task
    def policy_creation(self):
        customerInfo = {
            "customerId": self.customer_ID,
            "firstname": self.firstname,
            "lastname": self.lastname,
            "contactAddress": {
                "streetAddress": self.streetAddress,
                "postalCode": self.postalCode,
                "city": self.postalCode
            },
            "billingAddress": {
                "streetAddress": self.streetAddress,
                "postalCode": self.postalCode,
                "city": self.postalCode
            }
        }
        insuranceData = {
            "startDate": fake.date(),
            "insuranceType": choice(insuranceType),
            "deductible": {
                "amount": choice(deductibleAmount),
                "currency": "CHF"
            }
        }
        headers = {"X-Auth-Token": self.x_Auth_token}
        res = self.client.post(":8080/insurance-quote-requests",
                               json={"statusHistory": [],
                                     "customerInfo": customerInfo,
                                     "insuranceOptions": insuranceData
                                     },
                               headers=headers,
                               catch_response=True)
        print("--------------------------------------------------")
        print(f"policy has been requested by {self.firstname} {self.lastname} with email {self.email}\n", res.text)


class MyLoadTester(HttpUser):
    host = "http://" + ec2_instance_ip
    wait_time = constant(1)
    tasks = [loginWithDifferentAccount]
