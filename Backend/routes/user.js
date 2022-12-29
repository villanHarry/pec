const express = require("express");
const { default: mongoose } = require("mongoose");
const router = express.Router();
const userSchema = require("../models/userModel");
const db = require('../server');
var MongoClient = require('mongodb').MongoClient;



router.get('/login', async (req, res) => {

  try {
    const { email, pass } = req.body;
    if (email != null && pass != null) {
      const data = await userSchema.find({ "Email": email, "Password": pass });
      if (data.length>0) {
        res.json({
          message: "Login Succesful",
          user: {
          "Email": data[0]["Email"],
            "Fullname": data[0]["Fullname"],
            "Image": data[0]["Image"],}
        });
      } else {
        res.json({
          message: "User not Found",
          user: {
            "Email": "",
              "Fullname": "",
              "Image": "",}
          
        });
      }
    } else (
      res.json({
        message: "Headers missing",
      })
    )
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.post('/signup', async (req, res) => {

  try {
    const { email, pass ,fullname,image} = req.body;
    if (email != null && pass != null && fullname !=null && image!=null) {
      
      MongoClient.connect(process.env.DB, function(err, db) {
        if (err) {res.json({message: error});}
        var dbo = db.db("PEC"); 
        dbo.collection("users").insertOne({
          "Email": email,
          "Password": pass,
          "Fullname": fullname,
          "Image": image
        }, function(err, response) {
          if (err) {
            res.json({
              message: "SignUp Unsuccesful",
              user: {
                "Email": "",
                  "Fullname": "",
                  "Image": "",}
            });
          }
          res.json({
            message: "SignUp Succesful",
            user: {
              "Email": email,
              "Fullname": fullname,
              "Image": image}
          });
          db.close
        });
      });
    } else (
      res.json({
        message: "Headers missing",
      })
    )
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;

// jwt
// bcrypt
// joi
// joi - password - complexity
// uuid
