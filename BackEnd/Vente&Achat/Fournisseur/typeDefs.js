      
    const { gql } = require('apollo-server-express');
    const typeDefs = gql`
    
    
    extend type Query{
      
        GetFournisseurs(IdEnt:ID!):[Fournisseur]
        GetFournisseur(Nom:String!,IdEnt:ID!):[Fournisseur]
     }
     type Fournisseur{
        id:ID!
        Nom:String!
        Prenom:String!
        Email:String!
        Phone:Int!
        Civility:String!
        IdEnt:Entreprise
        NomEntreprise:String!
        
        Comment:String
        createdAt:Date
        updatedAt:Date



     }
     extend type Mutation{
        
        CreateFournisseur(Nom:String!,Prenom:String!,Email:String!,Phone:Int!,NomEntreprise:String!,Civility:String!,Comment:String,IdEnt:ID!):Int!
        UpdateFournisseur(IdFournisseur:ID!,Nom:String!,Prenom:String!,Email:String!,Phone:Int!,NomEntreprise:String!,Civility:String!,Comment:String):Boolean
        DeleteFournisseur(IdFournisseur:ID!):Boolean
        FournisseurSendMail(IdFournisseur:ID!,Object:String,Titel:String):Boolean
    }
    `;
    module.exports=typeDefs;  




     