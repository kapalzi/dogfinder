const mongoose = require('mongoose')

const DogPhotoSchema = mongoose.Schema({
    dogId: String,
    photo: String,//{ data: Buffer, contentType: String },
})

module.exports = mongoose.model('DogPhotos', DogPhotoSchema)