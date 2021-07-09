      
    const { gql } = require('apollo-server-express');
    const typeDefs = gql`
    
    
    extend type Query{
      
       
        GetArticle(Label:String!,IdEnt:ID):[Article]
     }
     type Article{
        id:ID!
        refArticle:Int
        Label:String!    
        PrixAchat:Float!
        PrixVente:Float!
        IdEnt:Entreprise!
        createdAt:Date
        updatedAt:Date



     }
     extend type Mutation{
        
        CreateArticle(Label:String!,PrixAchat:Float!,PrixVente:Float!,IdEnt:ID!):Int!
        UpdateArticle(IdArticle:ID!,Label:String!,PrixAchat:Float!,PrixVente:Float!,IdEnt:ID!):Boolean
        DeleteArticle(IdArticle:ID!):Boolean
       
    }
    `;
    module.exports=typeDefs;  
