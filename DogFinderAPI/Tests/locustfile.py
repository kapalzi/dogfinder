# http://localhost:8089
from locust import HttpLocust, TaskSet, task, between
import random
import time
import uuid

def str_time_prop(start, end, format, prop):

    stime = time.mktime(time.strptime(start, format))
    etime = time.mktime(time.strptime(end, format))

    ptime = stime + prop * (etime - stime)

    return time.strftime(format, time.localtime(ptime))


def random_date(start, end, prop):
    return str_time_prop(start, end, '%Y-%m-%d %I:%M %p', prop)

class UserBehavior(TaskSet):

    def on_start(self):
        # Each locust user gets a different id
        self.register()

    @task(1)
    def register(self):
        self.locust.random_id = str(uuid.uuid4())
        self.locust.random_mail = str(uuid.uuid4())
        self.client.post('/api/users/register',
                {'username': self.locust.random_id, 'password': 'qwe', 'email':self.locust.random_mail+"@email.com"})

    @task(1)
    def login(self):
        self.client.post('/api/users/login',
                {'username': self.locust.random_id, 'password': 'qwe'})

    @task(4)
    def get_index(self):
       self.client.get('/api/dogs')

    @task(4)
    def addDog(self):
        self.client.post('/api/dogs', {
                "photo": '',
                "breed": 'Shiba Inu',
                "longitude": random.uniform(-180, 180),
                "latitude": random.uniform(-85, 85),
                "seenDate": random_date("2010-1-1 1:30 PM", "2019-11-11 4:50 AM", random.random()),
                "user": '5dd00491debab47644b26fd5',
                "isSpotted": "true",
                "size": 0,
                "color": 'Light brown',
                "gender": 0,
                "depiction": 'Poor dog',
                "location": {
                    "type": "Point",
                    "coordinates": []
                 }
                        })
    @task(4)
    def getDogsByDate(self):
        self.client.get('/api/dogs/date?areSpotted=true&page=1')

    @task(4)
    def getDogsByMap(self):
        self.client.get('/api/dogs/map?areSpotted=true&longitude=20.8590792&latitude=64.958041&page=0&radius=5000')


class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    wait_time = between(5,9)
    host = "http://localhost:5000"

    # db.dogs.createIndex({ "location": "2dsphere" })
