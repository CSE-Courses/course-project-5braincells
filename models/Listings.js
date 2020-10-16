const mongoose = require('mongoose');
 const timestamp = require('mongoose-timestamp');
 const { ObjectId } = require('mongoose');

 const ListingsSchema = new mongoose.Schema({
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
 ListingsSchema.plugin(timestamp);

 const Listings = mongoose.model('Listings',ListingsSchema);
 module.exports = Listings;
