var mongoose =require('mongoose');
const User =mongoose.model('User',{
    Nom:{type:String,default:'vide'},
    Prenom:{type:String,default:'vide'},
    Email:{type:String,default:'vide'},
    Phone:{type:Number,deafult:12345698},
    Password:{type:String,default:'vide'},
    Role:{type:mongoose.Schema.Types.ObjectId,ref:'Role'},
    IdEnt:{type:mongoose.Schema.Types.ObjectId,ref:'Entreprise',default:null},
    verifyingcode:{type:Number},
    IsVerified:{type:Boolean,default:false},
    Suspended:{type :Boolean ,default:false},
    Photo:{type:String,default:'main.jpg'},


});
module.exports=User;