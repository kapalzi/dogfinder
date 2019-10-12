const express = require('express')
const router = express.Router()
const Dog = require('../../models/Dog')
var fs = require('fs')
const path = require('path')
const uuidv4 = require('uuid/v4');
const auth = require("../../middleware/auth");

//Get All
router.get('/', auth, async (req, res) => {
    try {
        const dogs = await Dog.find()
        res.json(dogs)
    } catch(err) {
        console.log(err)
        res.json({ message: err })
    }
})

//Get filtered dog
router.get('/photo/:id', async (req, res) => {
    console.log(req.params.id)
    try {
        const dogs = await Dog.find()
        res.json(
            dogs.filter(dogs => dogs._id === req.params.id)
        )
    } catch (err) {
        res.json({ message: err })
    }
})

//Add new
router.post('/', async (req, res) => {
    console.log("Przyszedl!")
    const nameOfPhoto = uuidv4()
    const dog = new Dog({
        breed: req.body.breed,
        longitude: req.body.longitude,
        latitude: req.body.latitude,
        seenDate: req.body.seenDate,
        user: req.body.user,
        photoName: nameOfPhoto,
    })

    var base64Data = req.body.photo.replace(/^data:image\/jpeg;base64,/, "");
    const pathToSave = path.join(__dirname, '../../data/img/'+ nameOfPhoto + '.jpg')
    console.log(pathToSave)
    fs.writeFile(pathToSave, base64Data, "base64", function(err) {
            if (err) {
                console.log(err);
        } else {
            console.log("success");
            }
        });
        
        dog.photoName = nameOfPhoto + '.jpg'
        console.log(dog)
    try {
        const savedDog = await dog.save()
        res.json({ message: "Successfully saved dog!"})

    } catch (err) {
        res.json({ message: err })
    }
})

module.exports = router