const mongoose = require('mongoose');
 const timestamp = require('mongoose-timestamp');
 const { ObjectId } = require('mongoose');

 const BookmarksSchema = new mongoose.Schema({
   //add requirements

date:{
    type : String,
    default : ""

},
bookmarks :{
    type : String,
    default :""
}




 });
 BookmarksSchema.plugin(timestamp);

 const BookMarks = mongoose.model('BookMarks',BookmarksSchema);
 module.exports = BookMarks;