      
    const { gql } = require('apollo-server-express');
    const typeDefs = gql`
    
    
    extend type Query{
      
        GetClients(IdEnt:ID):[Client]
        GetClient(Nom:String!,IdEnt:ID):[Client]
     }
     type Client{
        id:ID!
        Nom:String!
        Prenom:String!
        Email:String!
        Phone:Int!
        IdEnt:Entreprise
        Civility:String!
        
        Comment:String
        createdAt:Date
        updatedAt:Date



     }
     extend type Mutation{
        
        CreateClient(Nom:String!,Prenom:String!,Email:String!,Phone:Int!,Civility:String!,Comment:String,IdEnt:ID!):Int!
        UpdateClient(IdClient:ID!,Nom:String!,Prenom:String!,Email:String!,Phone:Int!,Civility:String!,Comment:String):Boolean
        DeleteClient(IdClient:ID!):Boolean
        ClientSendMail(IdClient:ID!,Object:String,Titel:String):Boolean
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