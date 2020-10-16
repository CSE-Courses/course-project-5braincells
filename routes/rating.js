const Users = require('../models/Users');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const Ratings = require('../models/Ratings');
const e = require('express');

module.exports = app =>{

  app.get('/getRatingById/:id', async(req,res) =>{
      try{
        user_id = req.params.id;
        const user = await  Users.findById(user_id);
    
        list_id = user.ratings;
        list = [];
        for(var i = 0; i< list_id.length; i++){
            list.push(await Ratings.find(list_id[i]));
        }
        res.send(list);
        
      
      }
      catch(err){
            res.send(err);
      }



})

app.get('/getAvgStars/:id' , async( req,res) =>{
    try{
        user_id = req.params.id;
        const user = await  Users.findById(user_id);
    
        list_id = user.ratings;
        total = 0;
        for(var i = 0; i< list_id.length; i++){

            let x = await Ratings.find(list_id[i]);
            total = total + parseInt((x[0].stars));
            
        }
        console.log(total)
        total = total / list_id.length;
       total = JSON.stringify({avg : total});
        
        res.send(total);
    }
    catch(err){
            res.send(err);
    }
})

}