      
    const { gql } = require('apollo-server-express');
    const typeDefs = gql`
    
    
    extend type Query{
      
       
        GetCategory(Label:String!,IdEnt:ID):[Category]
     }
     type Category{
        id:ID!
        Label:String!
        Description:String!        
        IdEnt:Entreprise
        createdAt:Date
        updatedAt:Date



     }
     extend type Mutation{
        
        CreateCategory(Label:String!,Description:String!,IdEnt:ID!):Int!
        UpdateCategory(IdCategory:ID!,Label:String!,Description:String!):Boolean
        DeleteCategory(IdCategory:ID!):Boolean
       
    }
    `;
    module.exports=typeDefs;  
/*const { gql } = require('apollo-server-express');
const typeDefs = gql`



     type Query{
     GetClients:[Client]
     GetClient(Nom:String!):Client
    
     }
     
     type Mutation{
        
    }
`;
module.exports=typeDefs;*/