const Article = require('./Article.js');
var ObjectId = require('mongoose').Types.ObjectId;

const resolvers={
    Query:{
        
        GetArticle:async (_,{Label,IdEnt})=>{
            var id=ObjectId(IdEnt)
            try{
              console.log(IdEnt)
               return await Article.find({Label:new RegExp(Label, 'i'),IdEnt:id}).populate('IdEnt');


            }catch(exp){
                
                console.log(exp);
            }

        }


    },
    Mutation:{
        CreateArticle:async (_,{Label,PrixAchat,PrixVente,IdEnt})=>{
            try{
                var article = await Article.findOne({Label:Label,IdEnt:IdEnt});
                if(article==null)
              {var article = await new Article({Label:Label,PrixAchat:PrixAchat,PrixVente:PrixVente,IdEnt:IdEnt}).save();
               return 1;}else
               return 0


            }catch(exp){
                
                console.log(exp) ;
                return -1;
                
            }

        },
        UpdateArticle:async (_,{IdArticle,Label,Categorie,PrixAchat,PrixVente,Fournisseur})=>{
            try{
                var article = await Article.findByIdAndUpdate(IdArticle,{

                  $set:{
                    Label:Label,
                    Categorie:Categorie,
                    PrixAchat:PrixAchat,
                    PrixVente:PrixVente,
                    Fournisseur:Fournisseur
                    
                                      }  
                }
                );
                return true;
                


            }catch(exp){
                
                console.log(exp);
                
                
            }

        },
        DeleteArticle:async (_,{IdArticle})=>{
            try{
                var article = await Article.findByIdAndDelete(IdArticle) ;
                return true;
            }catch(exp){
                
                console.log(exp) ;
            }
        },
        
    }
}
module.exports=resolvers;