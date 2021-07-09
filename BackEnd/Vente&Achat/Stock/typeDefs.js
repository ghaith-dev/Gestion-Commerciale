      
    const { gql } = require('apollo-server-express');
    const typeDefs = gql`
    
    
    extend type Query{
      
       
        GetStockState(IdEnt:ID):[StockUnit]
     }
     type StockUnit{
        id:ID!
        Article:Article,
        Quant:Int!
        IdEnt:Entreprise!
        createdAt:Date
        updatedAt:Date



     }
     extend type Mutation{
        
        AddArticle(Article:ID!,Quant:Int!,IdEnt:ID!):Int!
        UpdateStockUnit(IdUnit:ID!,Quant:Int!):Boolean
        DeleteStockUnit(IdUnit:ID!):Boolean
       
    }
    `;
    module.exports=typeDefs;  
