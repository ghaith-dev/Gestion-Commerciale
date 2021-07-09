const Stock = require('./Stock.js');

var ObjectId = require('mongoose').Types.ObjectId;

const resolvers={
    Query:{
        
        GetStockState:async (_,{IdEnt})=>{
            var id=ObjectId(IdEnt)
            try{
              
               return await Stock.find({IdEnt:IdEnt}).populate('Article').populate('IdEnt');

            }catch(exp){
                
                console.log(exp);
            }

        }


    },
    Mutation:{
        AddArticle:async (_,{Article,Quant,IdEnt})=>{
            console.log(IdEnt);
            try{
                var unit = await Stock.findOne({Article:Article});
                if(unit==null)
              {var unit = await new Stock({Article:Article,Quant:Quant,IdEnt:IdEnt}).save();
               return 1;}else
               return 0


            }catch(exp){
                
                console.log(exp) ;
                return -1;
                
            }

        },
        UpdateStockUnit:async (_,{IdUnit,Article,Quant})=>{
            try{
                var article = await Stock.findByIdAndUpdate(IdUnit,{

                  $set:{
                    Article:Article,
                    Quant:Quant
                    
                                      }  
                }
                );
                return true;
                


            }catch(exp){
                
                console.log(exp);
                
                
            }

        },
        DeleteStockUnit:async (_,{IdUnit})=>{
            try{
                var article = await Stock.findByIdAndDelete(IdUnit) ;
                return true;
            }catch(exp){
                
                console.log(exp) ;
            }
        },
        
    }
}
module.exports=resolvers;