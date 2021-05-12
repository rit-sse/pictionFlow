const express = require('express');
const predictRouter = require('./routes/predict');
const bodyParser = require('body-parser');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const path = require('path')
const fs = require('fs');


var app = express();
const port = 8080;//8443 for https

app.use(helmet());

app.use(bodyParser.json());

app.use(cors());

app.use('/predict', predictRouter)

let logStream = fs.createWriteStream(path.join(__dirname,
    'logfile.log'), {flags: 'a'});
app.use(morgan('combined', {
    stream: logStream
}));


//we will get an SSL certificate -- I want to learn how to best secure that
/*
var https = require("https");
var privateKey  = fs.readFileSync(__dirname+'/../sslcert/server.key', 'utf8');
var certificate = fs.readFileSync(__dirname+'/../sslcert/server.crt', 'utf8');
var credentials = {key: privateKey, cert: certificate};

var httpsServer = https.createServer(credentials, app);
httpsServer.listen(8443);
*/
app.listen(port, () =>{
    console.log('listening on port ' + port);
});
