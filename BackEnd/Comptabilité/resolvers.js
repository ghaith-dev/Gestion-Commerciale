const CompteComptable = require('./Comptabilité.js');
const nodemailer = require("nodemailer");



var ObjectId = require('mongoose').Types.ObjectId;

  
const resolvers={
    Query:{
        
        GetComptes:async (_,{IdEnt})=>{
            var id=ObjectId(IdEnt)
            try{
              console.log(IdEnt)
                var x= await CompteComptable.find({IdEnt:id}).populate('IdEnt');
console.log(x);
                return x;
            }catch(exp){
                
                console.log(exp);
            }

        }


    },
    Mutation:{
        CreateCompte:async (_,{Numero,IdEnt,Label,Debit,Credit})=>{
            try{
              
              
 
                

               var resultat=Credit-Debit;
                
                    var compte= await  new CompteComptable({Numero,IdEnt,Label,Debit,Credit,Resultat:resultat}).save()
               
                    return 1
                  
 
             }catch(exp){
                 
                 console.log(exp) ;
                 return -1;
                 
             }
 

        },
        EcritureComptable:async(_,{Numero,Debit,Credit,IdEnt,})=>{
            try{
                console.log(Numero);
                var compte=  await  CompteComptable.findById(Numero)
               var ecriture= await CompteComptable.findByIdAndUpdate(Numero,{
                    $set:{
                        Debit:Debit+compte.Debit,
                        Credit:Credit+compte.Credit,
                        Resultat:(Credit+compte.Credit)-(Debit+compte.Debit),

                    }

                })
                console.log(compte.Debit);
                return true

            }catch(e){
                
                console.log(e);
                return false
            }
        }
        
    }
}
module.exports=resolvers;