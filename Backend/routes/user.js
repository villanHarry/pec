const express = require("express");
const { default: mongoose } = require("mongoose");
const router = express.Router();
const userSchema = require("../models/userModel");
const db = require('../server');
var MongoClient = require('mongodb').MongoClient;
const bcrypt = require('bcrypt');
const saltRounds = 10;

router.get('/login', async (req, res) => {
  try {
    const { email, pass } = req.body;
    if (email != null && pass != null) {

      const data = await userSchema.find({ "Email": email });

      if (data.length > 0) {
        bcrypt.compare(pass, data[0]["Password"], function (err, result) {
          if (result == true) {
            res.json({
              message: "Login Succesful",
              user: {
                "Email": data[0]["Email"],
                "Fullname": data[0]["Fullname"],
                "Image": data[0]["Image"],
                "UserType": data[0]["UserType"],
              }
            });
          } else {
            res.json({
              message: "Incorrect Password",
              user: {
                "Email": "",
                "Fullname": "",
                "Image": "",
                "UserType": "",
              }

            });
          }
        });
      } else {
        res.json({
          message: "Invalid Email",
          user: {
            "Email": "",
            "Fullname": "",
            "Image": "",
            "UserType": "",

          }

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
    const { email, pass, fullname, image } = req.body;
    let generated_pass = "";
    if (email != null && pass != null && fullname != null && image != null) {
      const data = await userSchema.find({ "Email": email });
      if (data.length > 0) {
        res.json({
          message: "User Already Exist with This Email",
          user: {
            "Email": "",
            "Fullname": "",
            "Image": "",
            "UserType": "",
          }
        })
      } else {
        bcrypt.hash(pass, saltRounds, function (err, hash) {
          generated_pass = hash;
        });
        MongoClient.connect(process.env.DB, function (err, db) {
          if (err) { res.json({ message: error }); }
          var dbo = db.db("PEC");
          dbo.collection("users").insertOne({
            "Email": email,
            "Password": generated_pass,
            "Fullname": fullname,
            "Image": image,
            "UserType": "user"
          }, function (err, response) {
            if (err) {
              res.json({
                message: "SignUp Unsuccesful",
                user: {
                  "Email": "",
                  "Fullname": "",
                  "Image": "",
                  "UserType": "",
                }
              });
            }
            res.json({
              message: "SignUp Succesful",
              user: {
                "Email": email,
                "Fullname": fullname,
                "Image": image,
                "UserType": "User",
              }
            });
            db.close
          });
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

module.exports = router;

// jwt
// bcrypt
// joi
// joi - password - complexity
// uuid
