const Users = require('../models/Users');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const Requests = require('../models/Request');
const e = require('express');

module.exports = app =>{

  app.get('/getRequestById/:id', async(req,res) =>{
      try{
        user_id = req.params.id;
        const user = await  Users.findById(user_id);
    
        list_id = user.listOfRequest;
        list = [];
        for(var i = 0; i< list_id.length; i++){
            list.push(await Requests.find(list_id[i]));
        }
        res.send(list);
        
      
      }
      catch(err){
            res.send(err);
      }



})

  app.get('/allRequest' , async(req,res)=>{


    try{
        const list = await Requests.find({});
        res.send(list);
    }
    catch(err){
      res.send(err)
    }
  })

  app.get('/request/jobType/:jobType' , async(req,res)=>{
    let job = req.params.jobType;


    try{
        const list = await Requests.find({jobType: job});
        res.send(list);
    }
    catch(err){
      res.send(err)
    }
  })


}