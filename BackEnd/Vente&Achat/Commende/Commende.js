
var mongoose =require('mongoose');
const AutoIncrement = require('mongoose-sequence')(mongoose);


const Commende =mongoose.model('Commende', mongoose.Schema({
     Numero:{type:Number,default:0},
    TotalHT:{type:Number,deafult:0.0},
   TotalTTC:{type:Number,deafult:0.0},
     Article:[{type:mongoose.Schema.Types.ObjectId,ref:'Article'}],
     Quant :[{type:Number}],
     Client:{type:mongoose.Schema.Types.ObjectId,ref:'Client'},
      IdEnt:{type:mongoose.Schema.Types.ObjectId,ref:'Entreprise'},
    
},{timestamps:true}).plugin(AutoIncrement, {inc_field: 'Numero'})
);
module.exports=Commende;