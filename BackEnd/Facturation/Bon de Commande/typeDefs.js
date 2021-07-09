      
    const { gql } = require('apollo-server-express');
    const typeDefs = gql`
    
    
    extend type Query{
      
       
      GetBonDeCommande(IdEnt:ID):[BonDeCommande]
     }
     type BonDeCommande{
        id:ID!
        refBonDC:Int!
        Commande:Commende
        Client:Client
        IdEnt:Entreprise!
        createdAt:Date
        updatedAt:Date
     
        


     }
     extend type Mutation{
        
      CreateBonDeCommande(Commande:ID!,Client:ID!,IdEnt:ID!):Int!
      SendBonDeCommandeToClient(IdBonDC:ID!):Boolean!

       
    }
    `;
    module.exports=typeDefs;  
