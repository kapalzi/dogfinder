const mongoose = require('mongoose')

const DogSchema = mongoose.Schema({
    breed: String,
    latitude: Number,
    longitude: Number,
    seenDate: Date,
    // photo: String,//{ data: Buffer, contentType: String },
    photoName: String,
    user: String
})

module.exports = mongoose.model('Dogs', DogSchema)