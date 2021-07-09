
var mongoose =require('mongoose');

const Stock =mongoose.model('StockUnit', mongoose.Schema({
    
    Article:{type:mongoose.Schema.Types.ObjectId,default:null,ref:'Article'},
    Quant:{type:Number,default:0},
    IdEnt:{type:mongoose.Schema.Types.ObjectId,ref:'Entreprise'},
    
   

},{timestamps:true})
);
module.exports=Stock;