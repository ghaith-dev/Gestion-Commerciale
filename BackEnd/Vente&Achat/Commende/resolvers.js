const Commende = require('./Commende.js');
const Articlee = require('../Article/Article');
var ObjectId = require('mongoose').Types.ObjectId;


const resolvers={
    Query:{
        
        GetCommende:async (_,{IdEnt})=>{
            var id=ObjectId(IdEnt)
            try{
              
               
               var x= await (Commende.find({IdEnt:id}).populate('Article').populate('Client'));
             return x;

            }catch(exp){
                
                console.log(exp);
            }

        }


    },
    Mutation:{
        CreateCommende:async (_,{Article,Quant,IdEnt,Client})=>{
            try{
               var Totaleht=0;
             console.log(Article);
             console.log(Quant);

                var article= await Articlee.find({_id:Article})
                
                for(let i=0;i<article.length;i++){
                    Totaleht=Totaleht+(Number.parseFloat( article[i].PrixVente)*Quant[i]);
                    
                }
                   var commende= await new Commende({TotalHT:Totaleht,TotalTTC:(Totaleht*1.19),Article:Article,Quant:Quant,IdEnt:IdEnt,Client:Client}).save();
                   console.log(Totaleht); 
                   console.log(Totaleht*1.19)
                            
               return 1
                 

            }catch(exp){
                
                console.log(exp) ;
                return -1;
                
            }

        },
        
        DeleteCommende:async (_,{Numero})=>{
            try{
                var article = await Commende.findOneAndDelete({Numero:Numero}) ;
                return true;
            }catch(exp){
                
                console.log(exp) ;
            }
        },
        
    }
}
module.exports=resolvers;