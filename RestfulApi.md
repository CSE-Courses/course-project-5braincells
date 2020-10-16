#Users: 
firstname : String(first name of user)
email: String(email of user) (required) 
phone: String(Phone number or user) 
password: String(Hashed password of user)
location: String(Location of user)
listOfJobs: Array[ObjectId](Array of job listings of the user)
ratings: Array[ObjectId](Array of Ratings of the user)

#Listings:
jobType: String(type of job)
langauge: String(language)
description : String(Description of the listing)
owner: ObjectId(Id of the user who posted the listing)

#Ratings
stars: String(the stars out of 5 of the review)
comment: String(comment of the review)
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


___________________________________________________________________________

URL : '/getById/:id'

Method:GET

URL Params: User's id

Data Parameters: None

Sucess Response: Code: 200 Content : User info in Json

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl https://job-5cells.herokuapp.com/getById/5f7267a58d607a000420675d

Sample Response : {"firstname":"Yingwei",
                  "lastname":"",
                  "email":"yingei82599@gmail.com",
                  "password":"$2a$14$dz/1h8Be9IrIr5MAyyPEFuxgkjU6pG05dRCb0WZ2fhO7ZhL0Nyxga",
                  "listOfJobs":["5f88a9482f0fe75a463ed557","5f88a985ef0dd55a8b50c634","5f88a9cc0340c85ae4835ffa","5f88b12d55b4420004ec81ce","5f88e594e3c27b85a5cc09cc"],"location":"Amhest, NY","phone":"6469189003","ratings":["5f88cf9f8e8c6a731ef68398","5f88d066faf50a0004e02f33"],"_id":"5f7267a58d607a000420675d","updatedAt":"2020-10-16T00:13:08.914Z","createdAt":"2020-09-28T22:45:59.670Z","__v":0}
___________________________________________________________________________

URL : '/addListing'

Method: POST

URL Params: None

Data Parameters: {
    "jobType" : (Job of Listing),
    "user_id" : (user's id),
    "language" : (language of the listing),
    "description": (description of the listing)
}

Sucess Response: Code: 200 Content : Listing's Id

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl -d '{
    "user_id" : "5f7267a58d607a000420675d",
    "jobType" : "Tutoring",
    "language": "French",
    "description": "Funyqwe"
}' -H "Content-Type: application/json" -X POST https://job-5cells.herokuapp.com/addListing

Sample Response : "5f88f5b5cc7a3b0004ddf77a"


___________________________________________________________________________

URL : '/addRatings'

Method: POST

URL Params: None

Data Parameters: {
    "user_id" : (user's id)
    "stars" : (Job of Listing),
    "comment" : (comment),
}

Sucess Response: Code: 200 Content : Rating's Id

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl -d '{
    "user_id" : "5f7267a78d607a000420675e",
    "stars" : "5",
    "comment": "Good"
}' -H "Content-Type: application/json" -X POST https://job-5cells.herokuapp.com/addRatings

Sample Response : "5f88f92ecc7a3b0004ddf77c"

___________________________________________________________________________

URL : '/getRatingById/:id'

Method: GET

URL Params: user_id(user you want to get ratings of)

Data Parameters: None

Sucess Response: Code: 200 Content : Array of Ratings of the User id

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl https://job-5cells.herokuapp.com/getRatingById/5f7267a78d607a000420675e

Sample Response : [[{"stars":"5","comment":"Good","_id":"5f88f8811934470d6ac79385","updatedAt":"2020-10-16T01:33:53.820Z",
                    "createdAt":"2020-10-16T01:33:53.820Z","__v":0}],
                  [{"stars":"5","comment":"Good","_id":"5f88f92ecc7a3b0004ddf77c","updatedAt":"2020-10-16T01:36:46.520Z", "createdAt":"2020-10-16T01:36:46.520Z","__v":0}]]



___________________________________________________________________________

URL : '/getAvgStars/:id'

Method: GET

URL Params: user_id(user you want to get ratings of)

Data Parameters: None

Sucess Response: Code: 200 Content : Average of the star's of the user

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl https://job-5cells.herokuapp.com/getAvgStars/5f7267a78d607a000420675e

Sample Response : {"avg":5}


___________________________________________________________________________

URL : '/getListingsById/:id

Method: GET

URL Params: user_id(user you want to get listings of)

Data Parameters: None

Sucess Response: Code: 200 Content : Array of all the listings of the user

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl https://job-5cells.herokuapp.com/getListingsById/5f7267a78d607a000420675e

Sample Response : [[{"jobType":"Tutoring","language":"Frensch","description":"Funydqwe","_id":"5f88ff644a56a71333756f00",   
                  "updatedAt":"2020-10-16T02:03:16.153Z","createdAt":"2020-10-16T02:03:16.153Z","__v":0}],
                  [{"jobType":"Tutoring","language":"Frensch","description":"Funydqwe","_id":"5f88ff9d4a56a71333756f01", "updatedAt":"2020-10-16T02:04:13.289Z","createdAt":"2020-10-16T02:04:13.289Z","__v":0}],
                  [{"jobType":"Tutoring","language":"Frensch","description":"Funydqwe","_id":"5f88ff9e4a56a71333756f02", "updatedAt":"2020-10-16T02:04:14.171Z","createdAt":"2020-10-16T02:04:14.171Z","__v":0}]]










