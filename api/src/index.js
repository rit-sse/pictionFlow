const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const path = require('path')
const fs = require('fs');


var app = express();
const port = 8080;//8443 for https
// Security layer
app.use(helmet());

// using bodyParser to parse JSON bodies into JS objects
app.use(bodyParser.json());

// enabling CORS for all requests
app.use(cors());

// adding morgan to log HTTP requests
//const skipSuccess = (req, res)  => res.statusCode < 400;
//adding to morgan use parameters as skip: skipSuccess is potentially helpful
let logStream = fs.createWriteStream(path.join(__dirname,
    'logfile.log'), {flags: 'a'});

app.use(morgan('combined', {
    stream: logStream
}));
//app.get('path', function (appears to be a lambda commonly, but could pass a reference))
app.get('/', (req, res) =>{
    res.send("Welcome to my home");
});

//for using the python script:
function callPrediction(req, res){
    var spawn = require('child_process').spawn;
    // Parameters passed in spawn -
    // 1. type_of_script
    // 2. list containing Path of the script
    //    and arguments for the script 
    
    //http://localhost:12120/pythontest?data=FROMHTTP&(others)
    var process = spawn('python', ["./src/test_script.py",
                                    req.query.input]);

    process.stdout.on('data', function(data){
        res.send(data.toString());
    })
}



//localhost:12120/testpython?input=HELLOO

//define an endpoint
app.get('/testpython', callPrediction);

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
