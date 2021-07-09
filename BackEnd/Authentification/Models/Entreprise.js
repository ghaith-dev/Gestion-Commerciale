var mongoose =require('mongoose');
const Entreprise =mongoose.model('Entreprise',{ 
NomLegal:{type:String,default:null},
TypeDeCommerce:{type:String,default:null},

module:[{type:mongoose.Schema.Types.ObjectId,ref:'Module'}],
Phone:{type:Number,default:00000000},
Email:{type:String,default:'vide'},
Fax:{type:Number,default:'vide'},
Adresse:{type:String,default:'vide'},
Logo:{type:String,default:'vide'},

});
module.exports=Entreprise;