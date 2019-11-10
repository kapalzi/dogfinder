const mongoose = require('mongoose')
const mongoosePaginate = require('mongoose-paginate-v2')

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

DogSchema.plugin(mongoosePaginate)
module.exports = mongoose.model('Dogs', DogSchema)