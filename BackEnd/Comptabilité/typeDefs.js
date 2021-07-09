      
    const { gql } = require('apollo-server-express');
    const typeDefs = gql`
    
    
    extend type Query{
      
       
      GetComptes(IdEnt:ID):[CompteComptable]
     }
     type CompteComptable{
       id:ID!
       
      Numero:Int!
      Label:String!
      Debit:Float!
      Credit:Float!
     Resultat:Float!
     IdEnt:Entreprise!
        createdAt:Date
        updatedAt:Date
        
        


     }
     extend type Mutation{
        
      CreateCompte(Numero:Int!,IdEnt:ID!,Label:String!, Debit:Float!,Credit:Float!):Int!
      EcritureComptable(Numero:ID!,Debit:Float!,Credit:Float,IdEnt:ID!):Boolean!

       
    }
    `;
    module.exports=typeDefs;  
