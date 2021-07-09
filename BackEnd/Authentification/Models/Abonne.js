var mongoose =require('mongoose');
var Plan =require('./Plan.js')
const Abonne =mongoose.model('Abonne',{ 
user:{type:mongoose.Schema.Types.ObjectId,ref:'Entreprise'},
plan:{type:mongoose.Schema.Types.ObjectId,ref:'Plan'},
toRefund:{type:Boolean,default:false},
date:{type:Date},


});
module.exports=Abonne;