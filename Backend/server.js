const dotenv = require("dotenv").config("./");
const express = require("express");
const app = express();
const mongoose = require("mongoose");

mongoose.set("strictQuery", false);
mongoose.connect(process.env.DB);

const db = mongoose.connection;
db.on("error", console.error.bind(console, "connection error: "));
db.once("open", function () {
  console.log("Database Connected successfully");
});

app.use(express.json());
app.use("/user/", require("./routes/user"));

app.listen(process.env.PORT, () => {
  console.log("Server Started Succesfully at Port " + process.env.PORT);
});
