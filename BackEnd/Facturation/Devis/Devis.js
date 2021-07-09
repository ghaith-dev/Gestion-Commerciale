
var mongoose =require('mongoose');
const AutoIncrement = require('mongoose-sequence')(mongoose);
const Devis =mongoose.model('Devi', mongoose.Schema({
    refDevis:{type:Number,default:0},
    Articles:[{type:mongoose.Schema.Types.ObjectId,ref:'Article',}],
    qtt:[{type:Number,default:0}],
    TotaleHT:{type:Number,default:0,},
    TotaleTTC:{type:Number,default:0,},
    Client:{type:mongoose.Schema.Types.ObjectId,ref:'Client',},
   IdEnt:{type:mongoose.Schema.Types.ObjectId,ref:'Entreprise',},
    
   

},{timestamps:true}).plugin(AutoIncrement, {inc_field: 'refDevis'})
);
module.exports=Devis;