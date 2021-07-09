
var mongoose =require('mongoose');

const Client =mongoose.model('Client', mongoose.Schema({
    Nom:{type:String,default:'vide'},
    Prenom:{type:String,default:'vide'},
    Email:{type:String,default:'vide'},
    Phone:{type:Number,deafult:00000000},
    Civility:{type:String,default:'Vide'},
    IdEnt:{type:mongoose.Schema.Types.ObjectId,ref:'Entreprise',default:"607ffbd72a0ab9362c638d62"},
    Comment:{type:String,default:'Vide'},
   

},{timestamps:true})
);
module.exports=Client;