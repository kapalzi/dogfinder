const express = require('express')
const router = express.Router()
const Post = require('../../models/Post')

//Get All
router.get('/', async (req, res) => {
    try {
        const posts = await Post.find()
        res.json(posts)
    } catch(err) {
        res.json({ message: err })
    }
})

//Add new
router.post('/', async (req, res) => {
    const post = new Post({
        title: req.body.title,
        description: req.body.description
    })
    try {
        const savedPost = await post.save()
        res.json(savedPost)
    } catch (err) {
        res.json({ message: err })
    }
})

//Get filtered
router.post('/filteredPosts', async (req, res) => {
    try {
        const posts = await Post.find()
        res.json(
            posts.filter(posts => posts.title === req.body.title)
        )
    } catch (err) {
        res.json({ message: err })
    }
})

//Delete
router.delete('/:postId', async (req, res) => {
    try {
        const removedPost = await Post.remove({_id: req.params.postId})
        res.json(removedPost)
    } catch (err) {
        res.json({ message: err })
    }
})

module.exports = router