const mongoose = require("mongoose");

const MeetingSchema = new mongoose.Schema({
    
    MeetingId: {
    type: String,
  },
});

module.exports = mongoose.model('meetings', MeetingSchema);
