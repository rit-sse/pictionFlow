const express = require('express')
const morgan = require('morgan')
const connectDB = require('./config/db')
const passport = require('passport')
const bodyParser = require('body-parser')
const helmet = require('helmet')
const cors = require('cors')
const routes = require('./routes')
connectDB()

const app = express()





if(process.env.NODE_ENV === 'development'){
    app.use(morgan('dev'))
}

app.use(cors())
app.use(helmet())
app.use(express.urlencoded({extended: true, limit: '10mb'}))
app.use(express.json({limit: '10mb'}))

app.use(routes)


const PORT = process.env.PORT || 3000
app.listen(PORT, console.log(`Server running on port ${PORT}`))

module.exports.logStream
