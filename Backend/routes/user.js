const express = require("express");
const router = express.Router();
const userSchema = require("../models/userModel");



router.post('/login',async (req,res) => {
  try{
    console.log(req);
    const {email,pass} = req.body;
    console.log(email);
  res.status(200).json({
    email: "test",
  });
  } catch (err){
res.json({message:err.message});
  }
  /*try {
    const data = await userSchema.find({"Email":email,"Password":pass});
    res.json({
      message: "Login Succesful",
      user: data,
    });
  } catch (err) {
    res.status(500).json({ message : err.message });
  }*/
});

module.exports = router;

jwt
bcrypt
joi
joi-password-complexity
uuid
