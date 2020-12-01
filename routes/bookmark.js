const Users = require('../models/Users');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const BookMarks = require('../models/Bookmarks');
const e = require('express');

module.exports = app =>{



app.get('/getBookmarks', async(req,res) =>{
   
    try{
       
        const bookmarks = await BookMarks.find({});
        res.send(bookmarks)
    }
    catch(err){
        res.sendStatus(err);
    }
})
app.post('/addBookMark', async(req,res) =>{
    try{
        let user_id = req.body.user_id;
        let listing_id = req.body.listing_id;
        let date = new Date();
        let bookmark = new BookMarks();
        bookmark.date = date;
        bookmark.bookmarks = listing_id;
        let createdMark =  await bookmark.save();
        let bmid = createdMark._id;
        if(bmid){
            let markers = await Users.findById(user_id);
            let arr = markers.bookmarks;
            for(var i = 0; i<arr.length; i++){
                let book = await BookMarks.findById(arr[i]);
                if(book.bookmarks == listing_id){
                    res.status(400).send("This BookMark Exist!");
                }
            }
           
            const ello = await Users.findByIdAndUpdate(user_id, {"$push" :{"bookmarks": bmid}});
            res.send(bmid);
        }

    }catch(err){
        return(err);
    }
})

app.post("/bookmarks/delete", async(req,res) =>{
    let bookmark_id = req.body.bookmark_id;
    let user_id = req.body.user_id;
    try{
        BookMarks.findOne({_id : bookmark_id}, async(err, bookmark) =>{
            if(bookmark){
              const ello = await Users.findByIdAndUpdate(user_id, {"$pull" :{"bookmarks": bookmark_id}});
              const delSuc = await BookMarks.findByIdAndDelete(bookmark_id);
              res.status(200).send("Deleted successfully");
            }
            else{
              res.status(404).send("BookMark not Found")
            }
         
        })
    }catch(err){
        res.send(err);
    }
})
}