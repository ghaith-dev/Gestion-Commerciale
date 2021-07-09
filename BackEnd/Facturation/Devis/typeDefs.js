      
    const { gql } = require('apollo-server-express');
    const typeDefs = gql`
    
    
    extend type Query{
      
       
      GetDevis(IdEnt:ID):[Devis]
     }
     type Devis{
        id:ID!
        refDevis:Int!
        Articles:[Article]
        TotaleHT:Float
        TotaleTTC:Float
        Client:Client
        IdEnt:Entreprise!
        createdAt:Date
        updatedAt:Date
        qtt:[Int]!
        


     }
     extend type Mutation{
        TrnsformBonDeCommande(IdDevis:ID!):Boolean!
      CreateDevis(Articles:[ID!],Client:ID!,IdEnt:ID!,Quant:[Int!]):Int!
      SendDevisToClient(IdDevis:ID!):Boolean!

       
    }
    `;
    module.exports=typeDefs;  
