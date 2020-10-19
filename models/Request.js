const mongoose = require('mongoose');
 const timestamp = require('mongoose-timestamp');
 const { ObjectId } = require('mongoose');

 const RequestSchema = new mongoose.Schema({
   //add requirements

   jobType :{
      type: String,
      default :"",
      trim:true
   },
   language: {
     type:String,
     default :"",
     trim:true
   },

   description:{
     type:String,
     default :""

   },
   owner:{
     type: ObjectId,
     required : true
   }




 });
 RequestSchema.plugin(timestamp);

 const Requests = mongoose.model('Request',RequestSchema);
 module.exports = Requests;
