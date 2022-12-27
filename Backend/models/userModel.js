const mongoose = require("mongoose");

const UserSchema = new mongoose.Schema({
  /*_id:{
    type: mongoose.Types.ObjectId
  },*/
  Email: {
    type: String,
  },
  Password: {
    type: String,
  },
  Fullname: {
    type: String,
  },
  Image: {
    type: String,
  },
});

module.exports = mongoose.model('User', UserSchema);
