const mongoose = require('mongoose');
 const timestamp = require('mongoose-timestamp');


 const JobDescribtionSchema = new mongoose.Schema({
   //add requirements


   language: {
     type:String,
     default :"",
     trim:true
   },

   description:{
     type:String,
     default :""

   },




 });
 JobDescribtionSchema.plugin(timestamp);

 const JobDescription = mongoose.model('JobDescription',JobDescribtionSchema);
 module.exports = JobDescription;
