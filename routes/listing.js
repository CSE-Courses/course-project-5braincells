const Users = require('../models/Users');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const Listings = require('../models/Listings');
const e = require('express');

module.exports = app =>{

  app.get('/getListingsById/:id', async(req,res) =>{
      try{
        user_id = req.params.id;
        const user = await  Users.findById(user_id);
    
        list_id = user.listOfJobs;
        list = [];
        for(var i = 0; i< list_id.length; i++){
            list.push(await Listings.find(list_id[i]));
        }
        res.send(list);
        
      
      }
      catch(err){
            res.send(err);
      }



})

  app.get('/allListings' , async(req,res)=>{


    try{
        const list = await Listings.find({});
        res.send(list);
    }
    catch(err){
      res.send(err)
    }
  })

  app.get('/listings/jobType/:jobType' , async(req,res)=>{
    let job = req.params.jobType;


    try{
        const list = await Listings.find({jobType: job});
        res.send(list);
    }
    catch(err){
      res.send(err)
    }
  })


}