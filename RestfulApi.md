#Users: 
firstname : String(first name of user)
email: String(email of user) (required) 
phone: String(Phone number or user) 
password: String(Hashed password of user)
location: String(Location of user)
listOfJobs: Array[ObjectId](Array of job listings of the user)
ratings: Array[ObjectId](Array of Ratings of the user)
description : String(Description of user)
langauge : String(Langauge of user)
listOfRequest : Arrat[ObjectId](Array of request of the user)

#Listings:
jobType: String(type of job)
langauge: String(language)
description : String(Description of the listing)
owner: ObjectId(Id of the user who posted the listing)

#Ratings
stars: String(the stars out of 5 of the review)
comment: String(comment of the review)

#Requests:
jobType: String(type of job)
langauge: String(language)
description : String(Description of the Request)
owner: ObjectId(Id of the user who posted the Request)
_____________________________________________________________________

Purpose : Make sure the server is up and running

URL : '/'

Method:GET

URL Params: None

Data Parameters: None

Sucess Response: Code: 200 Content : {<div>Hello</div>}

Error Response: Code: 400 Content: {error: Invalid Content}

Sample call : curl https://job-5cells.herokuapp.com/

____________________________________________________________________

Purpose : Sign up a user(add user to the database with given data parameters)

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

Purpose : Check if the user email and password matches up in the database

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

Purpose : Get the user using the given user id

URL : '/getById/:id'

Method:GET

URL Params: id: (User's id)

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

Purpose : Get all the listings in the database

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

Purpose : Create a rating with given data parameter and add it to the user in the database

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

Purpose : Get all the ratings associated with the user using the user_id

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

Purpose : Get the average amount of star from all the user's ratings given the id

URL : '/getAvgStars/:id'

Method: GET

URL Params: id(id of user you want to get ratings of)

Data Parameters: None

Sucess Response: Code: 200 Content : Average of the star's of the user

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl https://job-5cells.herokuapp.com/getAvgStars/5f7267a78d607a000420675e

Sample Response : {"avg":5}


___________________________________________________________________________

Purpose : Get all the listings associated with the user given the user id

URL : '/getListingsById/:id

Method: GET

URL Params: id( id of user you want to get listings of)

Data Parameters: None

Sucess Response: Code: 200 Content : Array of all the listings of the user

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl https://job-5cells.herokuapp.com/getListingsById/5f7267a78d607a000420675e

Sample Response : [[{"jobType":"Tutoring","language":"Frensch","description":"Funydqwe","_id":"5f88ff644a56a71333756f00",   
                  "updatedAt":"2020-10-16T02:03:16.153Z","createdAt":"2020-10-16T02:03:16.153Z","__v":0}],
                  [{"jobType":"Tutoring","language":"Frensch","description":"Funydqwe","_id":"5f88ff9d4a56a71333756f01", "updatedAt":"2020-10-16T02:04:13.289Z","createdAt":"2020-10-16T02:04:13.289Z","__v":0}],
                  [{"jobType":"Tutoring","language":"Frensch","description":"Funydqwe","_id":"5f88ff9e4a56a71333756f02", "updatedAt":"2020-10-16T02:04:14.171Z","createdAt":"2020-10-16T02:04:14.171Z","__v":0}]]

___________________________________________________________________________

Purpose : Update the user's name in the database

URL : '/updateName

Method: POST

URL Params: None

Data Parameters: {
    "user_id" : (user's id)
    "updateName" : (new Name),
}
Sucess Response: Code: 200 Content : Updated user info

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl -d '{
    "user_id" : "5f88cfd834b4e3000458fd6c",
    "updateName" : "FirstName"
}' -H "Content-Type: application/json" -X POST https://job-5cells.herokuapp.com/updateName

Sample Response : {"firstname":"FirstName","lastname":"","email":"testing@gmail.com",
                   "password":"$2a$14$zB1YxWAKDirENPTPfXK9UOv14ycJ7m/hij5S1DVo8Is/DRsvzbHii","listOfJobs":  
                   ["5f8d370125b8e100188a6847","5f8d370325b8e100188a6848","5f8d370425b8e100188a6849","5f8d423825b8e100188a684a", "5f8d429025b8e100188a684b","5f8d502325b8e100188a684c","5f8d6cba1b79a100182e3958","5f8dc5e02f200d0018e45479", "5f8df2ee02379a00184fc72c"],"location":"Amherst, NY","phone":"1231231234","ratings": 
                   ["5f8a47743570ba000402d95d","5f8a477f3570ba000402d95e","5f8a47853570ba000402d95f","5f8a478b3570ba000402d960"],
                   "language":"","description":"I Flew","listOfRequest":["5f8e0e9592b6665eb314f0eb","5f8e0fb253d1c4001834bc17"],"_id":"5f88cfd834b4e3000458fd6c","updatedAt":"2020-10-19T23:00:45.855Z","createdAt":"2020-10-15T22:40:26.470Z","__v":0}

___________________________________________________________________________

Purpose : Update the user's email in the database

URL : '/updateEmail

Method: POST

URL Params: None

Data Parameters: {
    "user_id" : (user's id)
    "updateEmail" : (new Email),
}
Sucess Response: Code: 200 Content : Updated user info

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl -d '{
    "user_id" : "5f88cfd834b4e3000458fd6c",
    "updateEmail" : "testing@gmail.com"
}' -H "Content-Type: application/json" -X POST https://job-5cells.herokuapp.com/updateEmail

Sample Response : {"firstname":"FirstName","lastname":"","email":"testing@gmail.com",
                   "password":"$2a$14$zB1YxWAKDirENPTPfXK9UOv14ycJ7m/hij5S1DVo8Is/DRsvzbHii","listOfJobs":  
                   ["5f8d370125b8e100188a6847","5f8d370325b8e100188a6848","5f8d370425b8e100188a6849","5f8d423825b8e100188a684a", "5f8d429025b8e100188a684b","5f8d502325b8e100188a684c","5f8d6cba1b79a100182e3958","5f8dc5e02f200d0018e45479", "5f8df2ee02379a00184fc72c"],"location":"Amherst, NY","phone":"1231231234","ratings": 
                   ["5f8a47743570ba000402d95d","5f8a477f3570ba000402d95e","5f8a47853570ba000402d95f","5f8a478b3570ba000402d960"],
                   "language":"","description":"I Flew","listOfRequest":["5f8e0e9592b6665eb314f0eb","5f8e0fb253d1c4001834bc17"],"_id":"5f88cfd834b4e3000458fd6c","updatedAt":"2020-10-19T23:00:45.855Z","createdAt":"2020-10-15T22:40:26.470Z","__v":0}

___________________________________________________________________________

Purpose : Upate the user's description in the database

URL : '/updateDescription

Method: POST

URL Params: None

Data Parameters: {
    "user_id" : (user's id)
    "updateDescription" : (new Description),
}
Sucess Response: Code: 200 Content : Updated user info

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl -d '{
    "user_id" : "5f88cfd834b4e3000458fd6c",
    "updateDescription" : "I Flew"
}' -H "Content-Type: application/json" -X POST https://job-5cells.herokuapp.com/updateDescription

Sample Response : {"firstname":"FirstName","lastname":"","email":"testing@gmail.com",
                   "password":"$2a$14$zB1YxWAKDirENPTPfXK9UOv14ycJ7m/hij5S1DVo8Is/DRsvzbHii","listOfJobs":  
                   ["5f8d370125b8e100188a6847","5f8d370325b8e100188a6848","5f8d370425b8e100188a6849","5f8d423825b8e100188a684a", "5f8d429025b8e100188a684b","5f8d502325b8e100188a684c","5f8d6cba1b79a100182e3958","5f8dc5e02f200d0018e45479", "5f8df2ee02379a00184fc72c"],"location":"Amherst, NY","phone":"1231231234","ratings": 
                   ["5f8a47743570ba000402d95d","5f8a477f3570ba000402d95e","5f8a47853570ba000402d95f","5f8a478b3570ba000402d960"],
                   "language":"Spanish","description":"I Flew","listOfRequest":["5f8e0e9592b6665eb314f0eb","5f8e0fb253d1c4001834bc17"],"_id":"5f88cfd834b4e3000458fd6c","updatedAt":"2020-10-19T23:00:45.855Z","createdAt":"2020-10-15T22:40:26.470Z","__v":0}

___________________________________________________________________________

Purpose : Create a request with given data parameters and add it to the lust of user request

URL : '/addRequest'

Method: POST

URL Params: None

Data Parameters: {
    "jobType" : (job type)
    "language" : (language of request),
    "description":(discription of request)
    "user_id":(owner of the request)
}
Sucess Response: Code: 200 Content : Request Id

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl -d '{
    "user_id" : "5f88cfd834b4e3000458fd6c",
    "jobType" : "Flying",
    "language": "German",
    "description": "I Like to Fly High"
}' -H "Content-Type: application/json" -X POST https://job-5cells.herokuapp.com/addRequest

Sample Response : "5f8e1c6353d1c4001834bc1b"

___________________________________________________________________________

Purpose : Get all the request of the user given their id

URL : '/getRequestById/:id'

Method: GET

URL Params: id(User's id)

Data Parameters: None

Sucess Response: Code: 200 Content : Returns a list list of request of the user

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl https://job-5cells.herokuapp.com/getRequestById/5f88cfd834b4e3000458fd6c

Sample Response : [[{"jobType":"Tutoring","language":"Frensch","description":"Funydqwe","_id":"5f8e0e9592b6665eb314f0eb",
                    "owner":"5f88cfd834b4e3000458fd6c","updatedAt":"2020-10-19T22:09:25.091Z","createdAt":"2020-10-19T22:09:25.091Z","__v":0}],[{"jobType":"Flying","language":"German","description":"Funydqwe","_id":"5f8e0fb253d1c4001834bc17","owner":"5f88cfd834b4e3000458fd6c","updatedAt":"2020-10-19T22:14:10.203Z","createdAt":"2020-10-19T22:14:10.203Z","__v":0}],[{"jobType":"Flying","language":"German","description":"I Like to Fly High","_id":"5f8e1c6353d1c4001834bc1b","owner":"5f88cfd834b4e3000458fd6c","updatedAt":"2020-10-19T23:08:19.079Z","createdAt":"2020-10-19T23:08:19.079Z","__v":0}]]

___________________________________________________________________________

Purpose : Get all the Request in the database

URL : '/allRequest'

Method: GET

URL Params: None

Data Parameters: None

Sucess Response: Code: 200 Content : Returns a list of all the request in the database

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl https://job-5cells.herokuapp.com/allRequest

Sample Response : [{"jobType":"Tutoring","language":"Frensch","description":"Funydqwe","_id":"5f8e0e9592b6665eb314f0eb",
                    "owner":"5f88cfd834b4e3000458fd6c","updatedAt":"2020-10-19T22:09:25.091Z","createdAt":"2020-10-19T22:09:25.091Z","__v":0},{"jobType":"Flying","language":"German","description":"Funydqwe","_id":"5f8e0fb253d1c4001834bc17","owner":"5f88cfd834b4e3000458fd6c","updatedAt":"2020-10-19T22:14:10.203Z","createdAt":"2020-10-19T22:14:10.203Z","__v":0},{"jobType":"Test Title","language":"English","description":"Test Request Description","_id":"5f8e1b9153d1c4001834bc19","owner":"5f88d39c3e77a20004f1a421","updatedAt":"2020-10-19T23:04:49.308Z","createdAt":"2020-10-19T23:04:49.308Z","__v":0},{"jobType":"Flying","language":"German","description":"I Like to Fly High","_id":"5f8e1c6353d1c4001834bc1b","owner":"5f88cfd834b4e3000458fd6c","updatedAt":"2020-10-19T23:08:19.079Z","createdAt":"2020-10-19T23:08:19.079Z","__v":0}]

___________________________________________________________________________

Purpose : Get all the request with the given job type

URL : '/request/jobType/:jobType'

Method: GET

URL Params: jobType(type of job)

Data Parameters: None

Sucess Response: Code: 200 Content : Returns a list of all the request in the database with given job type

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl https://job-5cells.herokuapp.com/request/jobType/Tutoring

Sample Response : [{"jobType":"Tutoring","language":"Frensch","description":"Funydqwe","_id":"5f8e0e9592b6665eb314f0eb",
                    "owner":"5f88cfd834b4e3000458fd6c","updatedAt":"2020-10-19T22:09:25.091Z","createdAt":"2020-10-19T22:09:25.091Z","__v":0}]

___________________________________________________________________________

Purpose : Get all the listings with the given job type

URL : '/listings/jobType/:jobType'

Method: GET

URL Params: jobType(type of job)

Data Parameters: None

Sucess Response: Code: 200 Content : Returns a list of all the listings in the database with given job type

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl https://job-5cells.herokuapp.com/listings/jobType/Tutoring

Sample Response : [{"jobType":"Flying","language":"English","description":"I will teach you how to fly",
                    "_id":"5f8d423825b8e100188a684a","owner":"5f88cfd834b4e3000458fd6c","updatedAt":"2020-10-19T07:37:28.395Z","createdAt":"2020-10-19T07:37:28.395Z","__v":0},{"jobType":"Flying","language":"German","description":"Teachin Flight","_id":"5f8d6cba1b79a100182e3958","owner":"5f88cfd834b4e3000458fd6c","updatedAt":"2020-10-19T10:38:50.816Z","createdAt":"2020-10-19T10:38:50.816Z","__v":0}]


___________________________________________________________________________

Purpose : Return all the listings in the database with the given langauge

URL : '/listings/language'

Method: POST

URL Params: None

Data Parameters: {
    "language" : (language of listing),
}
Sucess Response: Code: 200 Content : list of all of the listings with the given language

Error Response: Code: 400 Content: {error: Bad Request}

Sample call : curl -d '{
    "language": "English"
}' -H "Content-Type: application/json" -X POST https://job-5cells.herokuapp.com/listings/language


Sample Response : [{"jobType":"IT Service","language":"English","description":"Fix your PC","_id":"5f8f25a99957d00018c06209",
                    "owner":"5f8f255e9957d00018c06208","updatedAt":"2020-10-20T18:00:09.965Z","createdAt":"2020-10-20T18:00:09.965Z","__v":0},{"jobType":"Tutor","language":"English","description":"Calculus tutoring","_id":"5f8f586a9957d00018c0621a","owner":"5f8f255e9957d00018c06208","updatedAt":"2020-10-20T21:36:42.667Z","createdAt":"2020-10-20T21:36:42.667Z","__v":0}]


___________________________________________________________________________


