var mongoose =require('mongoose');
const Article =mongoose.model('Article',{
    NomArticle:{type:String,default:null},
    Categorie:{type:mongoose.Schema.Types.ObjectId,default:null,ref:'Categorie'},
    Description:{type:String,default:'vide'},
    PrixU:{type:Number,default:0.00}


    


 });
 const Client =mongoose.model('Client',{
    NomClient:{type:String,default:'vide'},
    Phone:{type:Number,default:00000000},
    Mobile:{type:String,default:'vide'},
    Email:{type:String,default:'vide'},
    Adresse:{type:String,default:'vide'},
    Fax:{type:Number,default:00000000},
    Note:{type:String,default:'vide'}
 });
 const Categorie =mongoose.model('Categorie',{
   NomCategorie:{type:String,default:'vide'},
   Description:{type:String,default:'vide'},
});
 module.exports={Article,Client,Categorie};