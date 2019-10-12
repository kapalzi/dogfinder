const mongoose = require('mongoose')
const config = require('config');
const jwt = require('jsonwebtoken');
const Joi = require('joi');
const UserSchema = mongoose.Schema({

    email: {
        type: String,
        unique: true,
        required: true,
        trim: true
      },
      username: {
        type: String,
        unique: true,
        required: true,
        trim: true
      },
      password: {
        type: String,
        required: true,
      }
})

//custom method to generate authToken 
UserSchema.methods.generateAuthToken = function() { 
  const token = jwt.sign({ _id: this._id }, config.get('myprivatekey')); //get the private key from the config file -> environment variable
  return token;
}

const User = mongoose.model('User', UserSchema);

function validateUser(user) {
  const schema = {
    username: Joi.string().min(3).max(50).required(),
    email: Joi.string().min(5).max(255).required().email(),
    password: Joi.string().min(3).max(255).required()
  };

  return Joi.validate(user, schema);
}

module.exports.User = User
exports.validate = validateUser

// module.exports = mongoose.model('Users', UserSchema)