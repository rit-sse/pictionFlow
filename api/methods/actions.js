var user = require('../schemas/user')
var jwt = require('jwt-simple')
var config = require('../config/dbconfig')
var logger = require('../logs/logger')
const { getLogger } = require('log4js')

const userlogger = getLogger('userLogger')
var functions = {
    addNew: function (req, res) {        
        if((!req.body.userid) || (!req.body.userCode)){
            res.json({success: false, msg: 'missing a field'})
            
        }
        else {
            var newUser = user({
                userid: req.body.userid,
                userCode: req.body.userCode
            });
            newUser.save(function (err, newUser){
                if(err){
                    res.json({success:false, msg: 'failed to save'})
                }
                else{
                    userlogger.info(`new user ${req.body.userid}`)
                    res.json({success:true, msg : `user saved ${newUser.userid}`})
                }
            })
        }
    },
    authenticate: function(req, res){
        user.findOne({
            userid: req.body.userid
        }, function (err, user) {
            if(err) throw err
            if(!user){
                res.status(403).send({success: false, msg: 'Authentication Failed No User Found'})
            }
            else {
                //compare and validate user
            }
        }
        )
    },
    filelog: function(data){

    }
}

module.exports = functions