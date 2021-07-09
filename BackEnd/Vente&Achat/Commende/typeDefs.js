      
    const { gql } = require('apollo-server-express');
    const typeDefs = gql`
    
    
    extend type Query{
      
       
      GetCommende(IdEnt:ID!):[Commende]

     }
      type Commende{
        id:ID!
        Numero:Int!
        TotalHT:Float!
       TotalTTC:Float!
       Article:[Article!]
       Client:Client!
       Quant :[Int]
        IdEnt:Entreprise!
        createdAt:Date
        updatedAt:Date
     }
     
     extend type Mutation{
        CreateCommende(Article:[ID!],Quant:[Int],IdEnt:ID!,Client:ID!):Int
        
        DeleteCommende(Numero:Int!):Boolean
       
    }
    `;
    module.exports=typeDefs;  
