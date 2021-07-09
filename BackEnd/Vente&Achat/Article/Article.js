
var mongoose =require('mongoose');
const AutoIncrement = require('mongoose-sequence')(mongoose);
const Article =mongoose.model('Article', mongoose.Schema({
    refArticle:{type:Number,default:0},
    Label:{type:String,default:'vide'},
    PrixAchat:{type:Number,deafult:0.0},
    PrixVente:{type:Number,deafult:0.0},
        IdEnt:{type:mongoose.Schema.Types.ObjectId,ref:'Entreprise',},
    
   

},{timestamps:true}).plugin(AutoIncrement, {inc_field: 'refArticle'})
);
module.exports=Article;