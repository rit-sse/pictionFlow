const router = require('express').Router();

router.get('/', async function callPrediction(req, res) {
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


});

