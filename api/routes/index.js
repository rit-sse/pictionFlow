const express = require('express')
const { addNew, authenticate} = require('../methods/actions')
const router = express.Router()

router.get('/', (req,res) => {
    res.send("Running")
})

router.post('/newuser', addNew)
router.post('/auth', authenticate)
module.exports =router 