const mongoose = require('mongoose')

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

module.exports = mongoose.model('Users', UserSchema)