# http://localhost:8089
from locust import HttpLocust, TaskSet, task
import random
import time

def str_time_prop(start, end, format, prop):

    stime = time.mktime(time.strptime(start, format))
    etime = time.mktime(time.strptime(end, format))

    ptime = stime + prop * (etime - stime)

    return time.strftime(format, time.localtime(ptime))


def random_date(start, end, prop):
    return str_time_prop(start, end, '%Y-%m-%d %I:%M %p', prop)

class UserBehavior(TaskSet):

    def on_start(self):
        self.login()

    @task(1)
    def login(self):
        self.client.post('/api/users/login/',
                {'username': 'qwe', 'password': 'qwe'})
    
    @task(1)
    def get_index(self):
	    self.client.get('/api/dogs')

    @task(2)
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

    

class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    host = "http://localhost:5000"