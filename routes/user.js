const Users = require('../models/Users');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const Listings = require('../models/Listings');
const Ratings = require('../models/Ratings');
const Requests = require('../models/Request');
const e = require('express');

module.exports = app =>{
  mongoose.set('useFindAndModify', false);
  app.get('/', (req,res)=>{
    res.send(`<div>Server's Up!</div>`)
  })

  app.get('/user' , async(req,res,next)=>{
        try{
        const users = await Users.find({});

        res.send(users);
        // res.sendStatus(200);
      }
      catch(err){
        res.sendStatus(400);
      }
  })

  app.get('/getById/:id' , async(req,res,next)=>{
    try{
      const user = await Users.findById(req.params.id);

    res.send(user);
    // res.sendStatus(200);
  }
  catch(err){
    res.sendStatus(400);
  }
})

  app.post('/signup', async (req, res)=>{

      try{


        const firstname = req.body.firstname;
        const lastname = req.body.lastname;
        const email = req.body.email;
        const password = req.body.password;
        const location = req.body.location;
        const phone = req.body.phone;
        const lat = req.body.lat;
        const long = req.body.long;
  
        Users.findOne({email:email}, async function(err, user){
      
          if(!user) {
            const newUser = new Users();
            newUser.firstname = firstname;
            newUser.lastname = lastname;
            newUser.password =  bcrypt.hashSync(password,14);
            newUser.email = email;
            newUser.listOfJobs = [];
            newUser.phone = phone;
            newUser.location = location;
            newUser.lat = 0.0;
            newUser.long = 0.0;
            const user = await newUser.save();
    
    
            res.status(201).send(user);
          }
          else{
            res.send("User Exist")
          }
          
        })
       
      }
      catch(err){
        res.sendStatus(400);
      }


});
//add listings
app.post('/addListing', async(req,res) =>{
  const user_id = req.body.user_id;
  console.log(user_id)
  const newList = new Listings();
  newList.jobType = req.body.jobType;
  newList.language = req.body.language;
  newList.description = req.body.description;
  newList.owner = user_id;

  const List = await newList.save();
  if(List){
    list_id = List._id;

    try{
      Users.findOne({_id : user_id}, async(err, user) =>{
        console.log(user_id)
        
        if(user){
          const ello = await Users.findByIdAndUpdate(user_id, {"$push" :{"listOfJobs": list_id}});
          res.send(list_id);
        }
      })

     
    } catch(err){
      res.send(404);
      return next(new errors.ResourceNotFoundError(`There is no user with id of ${user_id}`));
    }

    

  }
})
//Add ratings
app.post('/addRatings', async(req,res) =>{
  const user_id = req.body.user_id;

  const newRate = new Ratings();
  newRate.stars = req.body.stars;
  newRate.comment = req.body.comment;


  const Rating = await newRate.save();
  if(Rating){
    rating_id = Rating._id;

    try{
      Users.findOne({_id : user_id}, async(err, user) =>{
        if(user){
          
          const ello = await Users.findByIdAndUpdate(user_id, {"$push" :{"ratings": rating_id}});
          res.send(rating_id);
        }
      })

     
    } catch(err){
      res.send(404);
      return next(new errors.ResourceNotFoundError(`There is no user with id of ${user_id}`));
    }

    

  }
})

app.post('/addRequest', async(req,res) =>{
  const user_id = req.body.user_id;

  const newRequest = new Requests();
  newRequest.jobType = req.body.jobType;
  newRequest.language = req.body.language;
  newRequest.description = req.body.description;
  newRequest.owner = user_id;


  const Request = await newRequest.save();
  if(Request){
    request_id = Request._id;

    try{
      Users.findOne({_id : user_id}, async(err, user) =>{
        if(user){
          
          const ello = await Users.findByIdAndUpdate(user_id, {"$push" :{"listOfRequest": request_id}});
          res.send(request_id);
        }
      })

     
    } catch(err){
      res.send(404);
      return next(new errors.ResourceNotFoundError(`There is no user with id of ${user_id}`));
    }

    

  }
})

app.post('/updateName', async(req,res)=>{
    user_id = req.body.user_id;
    updateName = req.body.updateName;
   
    try{
       Users.findByIdAndUpdate(user_id, {"firstname": updateName}, async(err,user)=>{
            let updated = await Users.findById(user_id);
            res.send(updated);
      });

    }
    catch(err){
      console.log("triggered")
        res.send(err);
    }
})

app.post('/updateEmail', async(req,res)=>{
  user_id = req.body.user_id;
  updateEmail = req.body.updateEmail;
 
  try{
     Users.findByIdAndUpdate(user_id, {"email": updateEmail}, async(err,user)=>{
      let updated = await Users.findById(user_id);
      res.send(updated);
    });

  }
  catch(err){
    console.log("triggered")
      res.send(err);
  }
})

app.post('/updateLanguage', async(req,res)=>{
  user_id = req.body.user_id;
  updateLanguage = req.body.updateLanguage;
 
  try{
     Users.findByIdAndUpdate(user_id, {"$set": {"language": updateLanguage}, upsert:true}, async(err,user)=>{
      let updated = await Users.findById(user_id);
            res.send(updated);
    });

  }
  catch(err){
    console.log("triggered")
      res.send(err);
  }
})


app.post('/updateDescription', async(req,res)=>{
  user_id = req.body.user_id;
  updateDescription = req.body.updateDescription;
 
  try{
     Users.findByIdAndUpdate(user_id, {"$set": {"description": updateDescription}, upsert:true}, async(err,user)=>{
      let updated = await Users.findById(user_id);
            res.send(updated);
    });

  }
  catch(err){
    console.log("triggered")
      res.send(err);
  }
})

app.post('/login', async(req,res) =>{
  try{

    Users.findOne({email : req.body.email}, (err,user)=>{
    
      if(!user){
        res.sendStatus(404)
      }else{
        if(err || !bcrypt.compareSync(req.body.password, user.password)){
          res.sendStatus(404);
        }
        else{
          res.send(user);
        }
      }

    });


    
 
    
  }
  catch(err){
    console.log("Trig");
    res.sendStatus(404);
  }


})

app.post('/listings/delete', async(req,res) =>{
  try{
    const userId = req.body.userId;
    const listingId = req.body.listingId;

    Listings.findOne({_id : listingId}, async(err, listing) =>{
        if(listing){
          const ello = await Users.findByIdAndUpdate(userId, {"$pull" :{"listOfJobs": listingId}});
          const delSuc = await Listings.findByIdAndDelete(listingId);
          res.sendStatus(204);
        }
        else{
          res.status(404).send("Listing not Found")
        }
     
    })

   
    
  }
  catch(err){
    res.send(err);
  }
})



const nodemailer = require('nodemailer');

var transporter = nodemailer.createTransport(
  {
    service: 'gmail',
    auth: {
      user: 'cse442.5braincells@gmail.com',
      pass: 'qweqwe0987'
    }
  }
);

app.post('/verify', (req,res) => {
  const userId = req.body.userId;
  const userEmail = req.body.email;

  var mailOptions = {
    from: 'cse442.5braincells@gmail.com',
    to: userEmail,
    subject: 'Email verification for Application',
    text: 'Hello, click the link below to verify your account:' + ' https://job-5cells.herokuapp.com/verificationLink/' + userId + '.'
  };

transporter.sendMail(mailOptions, function(error, info){
  if(error){
    console.log('TESTING ERROR' + error)
  }
  else{
    console.log('Email send to userId: ' + userId);
  }
})

  res.sendStatus(200);
});

app.get('/verificationLink/:userId', (req,res) =>{
  const userId = req.params.userId;
  console.log(req.params.userId);
  try{
    Users.findByIdAndUpdate(userId, {"verify": true}, async(err,user)=>{
     res.send("updated");
   });

 }
 catch(err){
   console.log("triggered not working.")
 }
})

app.post('/update/location', async(req,res) =>{
  try{
    const userId = req.body.userId;
    const lat = req.body.lat;
    const long = req.body.long;
    const location = req.body.location;

    Users.findOne({_id : userId}, async(err, user) =>{
        if(user){
          const ello = await Users.findByIdAndUpdate(userId, {"$set" : {"lat" : lat, "long":long, "location":location}});
      
          
          res.send(ello);
        }
        else{
          res.status(404).send("User not Found")
        }
     
    })

   
    
  }
  catch(err){
    res.send(err);
  }
})

}
