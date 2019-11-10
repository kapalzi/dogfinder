# http://localhost:8089
from locust import HttpLocust, TaskSet, task
import random

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
                "longitude": random.uniform(0.0, 180.0),
                "latitude": random.uniform(0.0, 180.0),
                "seenDate": "2019-11-09T15:25:22.706Z",
                "user": '5da23f2d51d1b35eed20924f',
                "isSpotted": "true",
                "size": 0,
                "color": 'Light brown',
                "gender": 0,
                "depiction": 'Poor dog' 
                        })

    

class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    host = "http://localhost:5000"