const express = require('express')
const router = express.Router()
const Dog = require('../../models/Dog')
var fs = require('fs')
const path = require('path')
const uuidv4 = require('uuid/v4');
const auth = require("../../middleware/auth");

//Get All
// router.get('/', async (req, res) => {
//     try {
//         const dogs = await Dog.find()
//         res.json(dogs)
//     } catch(err) {
//         res.json({ message: err })
//     }
// })

//Get all at page
    router.get('/', async (req, res) => {

        try {
            const dogs = await Dog.find({isSpotted: req.query.areSpotted}).
            sort({seenDate: -1}).limit(10).skip(10*req.query.page)
        
            res.json(dogs)
            } catch(err) {
                res.json({ message: err })
            }
        })

//Add new
router.post('/', async (req, res) => {
    let nameOfPhoto = uuidv4()
    const dog = new Dog({
        breed: req.body.breed,
        longitude: req.body.longitude,
        latitude: req.body.latitude,
        seenDate: Date.now(),
        user: req.body.user,
        photoName: nameOfPhoto,
        isSpotted: req.body.isSpotted,
        size: req.body.size,
        color: req.body.color,
        gender: req.body.gender,
        depiction: req.body.depiction
    })

    if(req.body.photo == '') {
        nameOfPhoto = 'test_dog'
    } else {
        var base64Data = req.body.photo.replace(/^data:image\/jpeg;base64,/, "");
        const pathToSave = path.join(__dirname, '../../data/img/'+ nameOfPhoto + '.jpg')
    
        fs.writeFile(pathToSave, base64Data, "base64", function(err) {
                if (err) {
                    console.log(err);
            } else {
                console.log("success");
                }
            });
    }

        dog.photoName = nameOfPhoto + '.jpg'
    try {
        const savedDog = await dog.save()
        res.json({ message: "Successfully saved dog!"})

    } catch (err) {
        res.json({ message: err })
    }
})

module.exports = router
