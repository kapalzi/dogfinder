const auth = require("../../middleware/auth");
const bcrypt = require("bcrypt");
const { User, validate } = require("../../models/User");
const express = require("express");
const router = express.Router();

router.get("/current", auth, async (req, res) => {
  const user = await User.findById(req.user._id).select("-password");
  res.send(user);
});

router.post("/register", async (req, res) => {
  // validate the request body first
  const { error } = validate(req.body);
  if (error) return res.status(400).send(error.details[0].message);

  //find an existing user
  let user = await User.findOne({ email: req.body.username });
  if (user) return res.status(400).send("User already registered.");

  user = new User({
    username: req.body.username,
    password: req.body.password,
    email: req.body.email
  });
  user.password = await bcrypt.hash(user.password, 10);
  await user.save();

  const token = user.generateAuthToken();
  res.header("x-auth-token", token).send({
    _id: user._id,
    username: user.username,
    email: user.email
  });
});

router.post("/login", async (req, response) => {  
    let user = await User.findOne({ username: req.body.username });
    console.log(user)
    if (user) {

        bcrypt.compare(req.body.password, user.password, function(err, res) {
            if (err){
              console.log(err)
            }
            if (res) {
                const token = user.generateAuthToken();
                response.header("x-auth-token", token).send({
                  _id: user._id,
                  username: user.username,
                  email: user.email
                });
            } else {
              return response.status(400).send("Wrong password.");
            }
          });
         } else {
        return response.status(400).send("User does not exist.");
    }
  });

module.exports = router;