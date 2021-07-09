
var mongoose =require('mongoose');
const AutoIncrement = require('mongoose-sequence')(mongoose);
const CompteComptable =mongoose.model('CompteComptable', mongoose.Schema({
    Numero:{type:Number,default:0},
    Label:{type:String,default:'0'},
    Debit:{type:Number,default:0},
    Credit:{type:Number,default:0},
   Resultat:{type:Number,default:0},
   IdEnt:{type:mongoose.Schema.Types.ObjectId,ref:'Entreprise',},
   

}
));
module.exports=CompteComptable;