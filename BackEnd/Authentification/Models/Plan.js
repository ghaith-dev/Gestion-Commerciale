const { Timestamp } = require('bson');
var mongoose =require('mongoose');
const Plan =mongoose.model('Plan',{ 
    planType:{type:String,default:'vide'},
    prix:{type:Number,default:0.00},
    duree:{type:Number,default:0},

    
},

);
module.exports=Plan;