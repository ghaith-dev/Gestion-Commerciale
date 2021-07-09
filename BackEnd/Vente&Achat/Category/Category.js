var mongoose =require('mongoose');

const Category =mongoose.model('Category', mongoose.Schema({
    Label:{type:String,default:'vide'},
    Description:{type:String,default:'vide'},

    IdEnt:{type:mongoose.Schema.Types.ObjectId,ref:'Entreprise',default:"607ffbd72a0ab9362c638d62"},    
    
   

},{timestamps:true})
);
module.exports=Category;