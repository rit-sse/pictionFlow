var mongoose = require('mongoose')
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt')
var userSchema = new Schema( {
    userid:{
        type: String,
        require: true
    },
    userCode:{
        type: String,
        require: true
    }

})
//prehook to encrypt before save
userSchema.pre('save', function(next) {
    var user = this;
    if(this.isNew){
        bcrypt.genSalt(10, function (err, salt){
            if(err){
                return next(err)
            }
            bcrypt.hash(user.userCode, salt, (err, hash) => {
                if(err) {
                    return next(err)
                }
                user.userCode = hash;
                next()
            })
        })
    }
    else{
        return next()
    }
})
userSchema.methods.compareCode = function(code, cb){//cb is callback
    bcrypt.compare(code, this.userCode, function(err, isMatch){
        if(err){
            return cb(err)
        }
        cb(null, isMatch)
    })
}

module.exports = mongoose.model('user', userSchema)