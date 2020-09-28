const Users = require('../models/Users');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

module.exports = app =>{



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



  app.post('/signup', async (req, res)=>{

      try{


      const firstname = req.body.firstname;
      const email = req.body.email;
      const password = req.body.password;
      const location = req.body.location;
      const phone = req.body.phone;
      

        const newUser = new Users();
        newUser.firstname = firstname;
        newUser.password =  bcrypt.hashSync(password,14);
        newUser.email = email;
        newUser.listOfJobs = [];
        newUser.phone = phone;
        newUser.location = location;
        const user = await newUser.save();
        console.log(user);
        res.status(201).send(user)
      }
      catch(err){
        res.sendStatus(400);
      }


});

app.post('/login', async(req,res) =>{
  console.log(req.body)
  try{
    Users.findOne({email : req.body.email}, (err,user)=>{
      if(err || !user || !bcrypt.compareSync(req.body.password, user.password) ){
          res.sendStatus(400);
      }

      if(req.body.email == user.email && bcrypt.compareSync(req.body.password, user.password)){

        res.send(user)

      }


    });
  }
  catch(err){
    res.send(400);
  }


})



}
