const Category = require('./Category.js');
var ObjectId = require('mongoose').Types.ObjectId;

const resolvers={
    Query:{
        
        GetCategory:async (_,{Label,IdEnt})=>{
            var id=ObjectId(IdEnt)
            try{
              
               return await Category.find({Label:new RegExp(Label, 'i'),IdEnt:id});


            }catch(exp){
                
                console.log(exp);
            }

        }


    },
    Mutation:{
        CreateCategory:async (_,{Label,Description,IdEnt})=>{
            try{
                var category = await Category.findOne({Label:Label});
                if(category==null)
              {var category = await new Category({Label:Label,Description:Description,IdEnt:IdEnt}).save();
               return 1;}else
               return 0


            }catch(exp){
                
                console.log(exp) ;
                return -1;
                
            }

        },
        UpdateCategory:async (_,{IdCategory,Label,Description})=>{
            try{
                var client = await Category.findByIdAndUpdate(IdCategory,{

                  $set:{
                    Label:Label,
                    Description:Description
                    
                                      }  
                }
                );
                return true;
                


            }catch(exp){
                
                console.log(exp);
                
                
            }

        },
        DeleteCategory:async (_,{IdCategory})=>{
            try{
                var category = await Category.findByIdAndDelete(IdCategory) ;
                return true;
            }catch(exp){
                
                console.log(exp) ;
            }
        },
        
    }
}
module.exports=resolvers;