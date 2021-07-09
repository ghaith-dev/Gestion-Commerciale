
var mongoose =require('mongoose');
const AutoIncrement = require('mongoose-sequence')(mongoose);
const BonDeCommande =mongoose.model('Bon de commande', mongoose.Schema({
    refBonDC:{type:Number,default:0},
    Commande:{type:mongoose.Schema.Types.ObjectId,ref:'Commende',},
    Client:{type:mongoose.Schema.Types.ObjectId,ref:'Client',},
   IdEnt:{type:mongoose.Schema.Types.ObjectId,ref:'Entreprise',},
    
   

},{timestamps:true}).plugin(AutoIncrement, {inc_field: 'refBonDC'})
);
module.exports=BonDeCommande;