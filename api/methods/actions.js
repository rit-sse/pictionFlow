var user = require('../schemas/user')
var jwt = require('jwt-simple')
var config = require('../config/dbconfig')
var logger = require('../logging/logger')
const { getLogger } = require('log4js')

const userlogger = getLogger('userLogger')
var functions = {
    addNew: async function (req, res) {  
        

        if((!req.body.userid) || (!req.body.userCode)){
            return res.json({success: false, msg: 'missing a field'})
        }
        const exists = await user.exists({
            "userid": req.body.userid
        })
        if(exists){
            console.log(req.body.userid)
            res.json({success: false, msg: "user already exists"})
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
        }, function (err, found) {
            if(err) throw err
            if(!found){
                res.status(403).send({success: false, msg: 'Authentication Failed No User Found'})
            }
            else {
                found.compareCode(req.body.userCode, function(err, isMatch){
                    if(isMatch && !err){
                        var token = jwt.encode(user, config.secret)
                        res.json({success: true, token: token})
                    }
                    else {
                        return res.status(403).send({success: false, msg: 'Authentication failed. Wrong code for user'})
                    }
                })
            }
        }
        )
    },
    filelog: function(data){

    }
}

module.exports = functions