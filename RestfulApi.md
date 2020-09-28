#User: 
firstname : String(first name of user)
email: String(email of user) (required) 
phone: String(Phone number or user) 
password: String(Hashed password of user)
location: String(Location of user)
listOfJobs: Array[ObjectId](Array of job listings of the user)
_____________________________________________________________________


URL : '/'

Method:GET

URL Params: None

Data Parameters: None

Sucess Response: Code: 200 Content : {<div>Hello</div>}

Error Response: Code: 400 Content: {error: Invalid Content}

Sample call : curl https://job-5cells.herokuapp.com/

____________________________________________________________________

URL : '/signup'

Method:Post

URL Params: None

Data Parameters: {
    "firstname": (name of user),
    "password" : (password of user),
    "email" : (email of user),
    "phone" : (phone of user),
    "location" : (location of user)
}

Sucess Response: Code: 201 Content : User info in Json

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl -d '{
    "firstname": "Yingwei",
    "password" : "innovation",
    "email" : "yingwei123@gmail.com",
    "phone" : "646-918-9003",
    "location" : "1379 west 6th street Brooklyn Ny, 11204"
}' -H "Content-Type: application/json" -X POST https://job-5cells.herokuapp.com/signup

Sample Response : {"firstname":"Yingwei",
                   "email":"yingwei123@gmail.com",
                   "password":"$2a$14$MmRyHXvanmxJzk6fWR3PSe4ubLd.DjuLmjuLeAUBlvFhrZgcQNYQa",
                   "listOfJobs":[],
                   "location":"1379 west 6th street Brooklyn Ny, 11204",
                   "phone":"646-918-9003",
                   "_id":"5f725bd21181340004d379ed",
                   "updatedAt":"2020-09-28T21:55:32.521Z","createdAt":"2020-09-28T21:55:32.521Z","__v":0}

_______________________________________________________________________

URL : '/login'

Method:Post

URL Params: None

Data Parameters: {
    "password" : (password of user),
    "email" : (email of user)
}

Sucess Response: Code: 200 Content : User info in Json

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl -d '{
    "password" : "innovation",
    "email" : "yingwei123@gmail.com"
}' -H "Content-Type: application/json" -X POST https://job-5cells.herokuapp.com/login

Sample Response : {"firstname":"Yingwei",
                   "email":"yingwei123@gmail.com",
                   "password":"$2a$14$MmRyHXvanmxJzk6fWR3PSe4ubLd.DjuLmjuLeAUBlvFhrZgcQNYQa",
                   "listOfJobs":[],
                   "location":"1379 west 6th street Brooklyn Ny, 11204",
                   "phone":"646-918-9003",
                   "_id":"5f725bd21181340004d379ed",
                   "updatedAt":"2020-09-28T21:55:32.521Z","createdAt":"2020-09-28T21:55:32.521Z","__v":0}




