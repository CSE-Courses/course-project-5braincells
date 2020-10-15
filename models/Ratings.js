const mongoose = require('mongoose');
 const timestamp = require('mongoose-timestamp');


 const RatingsSchema = new mongoose.Schema({
   //add requirements


   stars: {
     type:String,
     default :0,
     trim:true
   },

   comment:{
     type:String,
     default :""

   },




 });
 RatingsSchema.plugin(timestamp);

 const Ratings = mongoose.model('Ratings',RatingsSchema);
 module.exports = Ratings;
