var mongoose =require('mongoose');
const PasswordRecovry =mongoose.model('PasswordRecovry',{
    PasswordRecovryCode:{type:Number,default:null},
    createdAt: { type: Date,  expires: 43200 , default: Date.now },
    Email:{type:String,require:true,default:'vide'},

    
},

);


module.exports=PasswordRecovry;