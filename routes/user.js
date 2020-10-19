const Users = require('../models/Users');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const Listings = require('../models/Listings');
const Ratings = require('../models/Ratings');
const e = require('express');

module.exports = app =>{

  app.get('/', (req,res)=>{
    res.send(`<div>Hello</div>`)
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



}
