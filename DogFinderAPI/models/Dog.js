const mongoose = require('mongoose')

const DogSchema = mongoose.Schema({
    breed: String,
    latitude: Number,
    longitude: Number,
    seenDate: Date,
    photoName: String,
    user: String,
    isSpotted: Boolean,
    size: Number,
    color: String,
    gender: Number,
    depiction: String
})

module.exports = mongoose.model('Dogs', DogSchema)