const express = require('express')
const router = express.Router()
const Dog = require('../../models/Dog')
const DogPhoto = require('../../models/DogPhoto')
const multiparty = require('multiparty')
var fs = require('fs')

//Get All
router.get('/', async (req, res) => {
    try {
        const dogs = await Dog.find()
        res.json(dogs)
    } catch(err) {
        console.log(err)
        res.json({ message: err })
    }
})

//Get Photos
router.get('/photos', async (req, res) => {
    try {
        const dogPhotos = await DogPhoto.find()
        console.log("Photos sent!")
        res.json(dogPhotos)
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
    
    const dog = new Dog({
        breed: req.body.breed,
        longitude: req.body.longitude,
        latitude: req.body.latitude,
        seenDate: req.body.seenDate,
        user: req.body.user,
    })

    try {
        const savedDog = await dog.save()
        res.json({ message: "Successfully saved dog!"})
        // console.log(savedDog.breed)

        const dogPhoto = new DogPhoto({
            photo: req.body.photo,
            dogId: savedDog.id
         })
         await dogPhoto.save()

    } catch (err) {
        res.json({ message: err })
    }
})

// router.post('/', async (req, res) => {

//     var form = new multiparty.Form();
//     form.parse(req, async (err, fields, files) => {
//         const dog = new Dog({
//             breed: fields.breed[0],
//             latitude: fields.latitude[0],
//             longitude: fields.longitude[0],
//             seenDate: fields.seenDate[0],
//             photo: {
//                 data: fs.readFileSync(files.photo[0].path),
//                 contentType: 'image.png',
//             },
//             user: fields.user[0]
//         })
//         try {
//             const savedDog = await dog.save()
            
//             res.json(savedDog)
//         } catch (err) {
//             console.log(err)
//             res.json({ message: err })
//         }
//     });
// })

module.exports = router