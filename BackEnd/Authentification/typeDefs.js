const { gql } = require('apollo-server-express');
const typeDefs = gql`


type Query{
  checkSubscription(Entr:ID!):Boolean
  checkRecovryCode(Email:String!,Code:Int!):Int!
  IsExpired(IdEntr:ID!):Boolean
  getUsers:[User!]
  getEmployees(IdEnt:ID!):[User!]
  getPlans:[Plan!]
  getFirm(idFirm:ID):Entreprise
  getPlan(id:ID!):Plan!
  getUser(Email:String!):[User!]
  getUserById(IdUser:String!):User!

  
  getmoduls:[Module!]
  getEntreprises:[Entreprise!]
  getEntreprise(NomLegal:String!):[Entreprise]
  getSubscriptions:[Abonne!]
  getSubscription(id:ID!):Abonne!
  IsVerified(IdUser:ID!):Boolean
  getRoles:[Role]!

 }
 type Role{
    id:ID!
    libelle:String!
 }
 type Abonne{
    id:ID!
    user:Entreprise!
    plan:Plan
    date:Date!
 }
 type Entreprise{
    id:ID!
    NomLegal:String!
    TypeDeCommerce:String!
    SacteurDactivite:String!
    module:[Module!]
    
    Phone:Int!
    Email:String!
    Fax:Int!
    Adresse:String!
    Logo:String!

 }
 type User{
    id:ID!
    Nom:String!
    Prenom:String!
    IdEnt:Entreprise
    Email:String!
    Password:String!
    Phone:Int
    Role:Role!
    Photo:String!
    Suspended:Boolean!
    IsVerified:Boolean!
 }
 type AuthPayload {
    token: String
    user: User
    Msg:String
  }

 

 

 scalar Date
 type Plan{
    id:ID!
    planType:String!,
    prix:Float!,
    duree:Int!
    
 }
 type Module{
    id:ID!
    libelle:String
    SubModule:[String]

 }
 type Mutation{
   InviteUser(Email:String!,IdEnt:ID!):Boolean
    SuspendUser(IdUser:ID!,Stat:Int!):Boolean
    CreateSubscription(user:ID!,plan:ID!):Abonne!
    CancelSubscription(IdSub:ID!):Boolean
    CreateRole(libelle:String!):Role!
    CreatePlan(planType:String!,prix:Float!,duree:Int!):Plan
    DeletePlan(IdPlan:ID!):Boolean
    UpdatePlan(IdPlan:ID!,planType:String!,prix:Float!,duree:Int!):Boolean
    CreatModule(libelle:String!,,SubModule:[String]):Module!
    UpdateModule(libelle:String!,IdModule:ID!):Boolean!
    CreatUser(Nom:String!,Prenom:String!,Email:String!,Phone:Int!,Password:String!,Role:ID!,IdEnt:ID,Photo:String!):AuthPayload
    Login(Email:String!,Password:String!):AuthPayload
    DeleteUser(IdUser:ID!):Boolean
    UpdateUser(IdUser:ID!,Nom:String!,Prenom:String!,Email:String!,Phone:Int!,Photo:String!):Boolean
    UpdatePassword(IdUser:ID!,Password:String!,oldPassword:String!):Int
    ChangeRole(IdUser:ID!,IdAdmin:ID!,IdRole:ID!):Boolean
	ResendCode(IdUser:ID!):Boolean
    SetIdEnt(IdUser:ID!,IdEnt:ID!):User!
    getVerified(IdUser:ID!,Code:Int!):Boolean
    GeneratePasswordRecovryCode(Email:String!):Int!
    PasswordRecovry(Email:String!,Password:String!):Boolean
    CreateEntreprise(NomLegal:String!,TypeDeCommerce:String!,module:[ID!],Phone:Int!,Email:String!,Fax:Int!,Adresse:String!,Logo:String!):Entreprise
    DeleteEntreprise(IdEntr:ID!):String! 
    UpdateEntreprise(IdEntr:ID!,NomLegal:String,Phone:Int,Email:String,Fax:Int,Adresse:String,Logo:String):String!
    
}
`;
module.exports=typeDefs;
