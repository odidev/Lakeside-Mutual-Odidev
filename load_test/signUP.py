import logging
import os.path
from locust import HttpUser, TaskSet, task, constant
from faker import Faker
import json
import environmentVariable

USERS = environmentVariable.user

fake = Faker()


def generator(number_of_records):
    CRED = []
    counter = 1
    for _ in range(number_of_records):
        CRED.append({"email": "admin" + str(counter) + "@example.com", "password": "1password",
                     "firstname": fake.first_name(), "lastname": fake.last_name(),
                     "streetAddress": fake.address(), "postalCode": fake.postcode(),
                     "city": fake.city(), "phoneNumber": fake.phone_number(),
                     "birthday": fake.date()})
        counter += 1
    with open('user_Credentials.json', 'w') as file:
        json.dump(CRED, file, indent=4)
    return CRED


if not os.path.exists("user_Credentials.json"):
    USER_CREDENTIALS = generator(USERS)
else:
    f = open("user_Credentials.json", "r")
    USER_CREDENTIALS = list(json.load(f))
    f.close()


class LoginWithUniqueUsersSteps(TaskSet):
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

    @task
    def on_start(self):
        if len(USER_CREDENTIALS) > 0:
            temp = USER_CREDENTIALS.pop()

            self.email = temp["email"]
            self.password = temp["password"]
            self.firstname = temp["firstname"]
            self.lastname = temp["lastname"]
            self.streetAddress = temp["streetAddress"]
            self.postalCode = temp["postalCode"]
            self.city = temp["city"]
            self.phoneNumber = temp["phoneNumber"]
            self.birthday = temp["birthday"]
            logging.info('Sign in with %s email and %s password', self.email, self.password)
            res1 = self.client.post("/auth/signup", json={'email': self.email, 'password': self.password},
                                    catch_response=True)
            print(res1.text)
            res2 = self.client.post("/auth", json={'email': self.email, 'password': self.password}, catch_response=True)
            print(res2.text)
            print(json.loads(res2.text)['token'])
            headers = {"X-Auth-Token": json.loads(res2.text)['token']}
            res3 = self.client.post("/customers", json={"firstname": self.firstname,
                                                        "lastname": self.lastname,
                                                        "streetAddress": self.streetAddress,
                                                        "postalCode": self.postalCode,
                                                        "city": self.city,
                                                        "phoneNumber": self.phoneNumber,
                                                        "birthday": self.birthday},
                                    headers=headers,
                                    catch_response=True)
            print(res3.text)
            print(res3.status_code)
            print(res3.headers)


class Login(HttpUser):
    host = "http://" + environmentVariable.host + ":8080"
    wait_time = constant(1)
    tasks = [LoginWithUniqueUsersSteps]
