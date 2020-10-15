const mongoose = require('mongoose');
 const timestamp = require('mongoose-timestamp');


 const RatingSchema = new mongoose.Schema({
   //add requirements


   stars: {
     type:number,
     default :0,
     trim:true
   },

   comment:{
     type:String,
     default :""

   },




 });
 RatingSchema.plugin(timestamp);

 const Rating = mongoose.model('JobDescription',RatingSchema);
 module.exports = Rating;
