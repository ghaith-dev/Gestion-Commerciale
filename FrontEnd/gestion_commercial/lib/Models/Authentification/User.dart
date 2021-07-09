import'Entreprise.dart';
import'Role.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import'package:gestion_commercial/Services/ApiConnection.dart';
import'package:gestion_commercial/Services/Authentifcation/Mutation.dart';
import'package:gestion_commercial/Services/Authentifcation/Query.dart';

class User{
  ApiConnection apiConnection = new ApiConnection();
 
  
String id;
String nom;
String prenom;
String email;
String password;
String photo;
int phone;
Role role;
String ident;

User(String id,String nom,String prenom,String email,String password,String photo,int phone,Role role){
  this.id=id;
  this.nom=nom;
  this.prenom=prenom;
  this.password=password;
  this.email=email;
  this.phone=phone;
  this.photo=photo;

  this.role=role;
  
}

 createUser()async{
   GraphQLClient client = apiConnection.clientToQuery();
   
         QueryResult result =  await client.mutate(
           MutationOptions(
             document: gql(new MutationGQL().creatUser(this.nom,this.prenom,this.email, this.phone,this.password,"60633b7f3d3d7e00c0c907f0",this.photo))
           )
         );
         return result;
 }
getverified( int code)async {
  GraphQLClient client = apiConnection.clientToQuery();
  QueryResult result =await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().getVerified(this.id,code))
    )
  );
  
  
   if(result.data['getVerified']==true){
     return true;
   }else{
     return false;
   }
}
void setId(String id){
  this.id=id;
}
  resendCode()async {
  GraphQLClient client = apiConnection.clientToQuery();
  QueryResult result =await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().resendCode(this.id))
    )
  );
  if(result.data['ResendCode']==true){
  return true;}else{
    return false;
  }
}
 
  setIdEnt(String idEnt)async{
   GraphQLClient client = apiConnection.clientToQuery();
   
         QueryResult result =  await client.mutate(
           MutationOptions(
             document: gql(new MutationGQL().setIdEnt(idEnt, this.id))
           )
           
         );
         this.ident=idEnt;
         return result;
 }
 generateRecovryCode(String email)async{
   GraphQLClient client = apiConnection.clientToQuery();
   
         QueryResult result =  await client.mutate(
           MutationOptions(
             document: gql(new MutationGQL().generatePasswordRecovryCode(email))
           )
         );
         return result;
 }
 checkRecovryCode(String email,int code)async{
   GraphQLClient client = apiConnection.clientToQuery();
   
         QueryResult result =  await client.query(
           QueryOptions(
             document: gql(new QueryGQL().checkRecovryCode(email, code)),
           )
         );
         return result;
 }
 getUsers()async{
   GraphQLClient client = apiConnection.clientToQuery();
   
         QueryResult result =  await client.query(
           QueryOptions(
             document: gql(new QueryGQL().getUsers()),
           )
         );
         return result;
 }
 getEmployees(var idEntreprise)async{
   GraphQLClient client = apiConnection.clientToQuery();
   
         QueryResult result =  await client.query(
           QueryOptions(
             document: gql(new QueryGQL().getEmployees(idEntreprise)),
           )
         );
         return result;
 }
  getUser(String email)async{
   GraphQLClient client = apiConnection.clientToQuery();
   
         QueryResult result =  await client.query(
           QueryOptions(
             document: gql(new QueryGQL().getUser(email)),
           )
         );
         return result;
  }
  passwordRecovry(String email,password)async{
   GraphQLClient client = apiConnection.clientToQuery();
   
         QueryResult result =  await client.mutate(
           MutationOptions(
             document: gql(new MutationGQL().passwordRecovry(email,password))
           )
         );
         return result;
 }
 login(String email,String password) async{
   GraphQLClient client = apiConnection.clientToQuery();
   
         QueryResult result =  await client.mutate(
           MutationOptions(
             document: gql(new MutationGQL().login(email,password))
           )
         );
         return result;


 }
 suspendUser(String idUser,int stat)async{
   GraphQLClient client = apiConnection.clientToQuery();
   
         QueryResult result =  await client.mutate(
           MutationOptions(
             document: gql(new MutationGQL().suspendUser(idUser,stat))
           )
         );
         return result;
 }
  inviteEmployee(String idEnt,String email)async{
   GraphQLClient client = apiConnection.clientToQuery();
   
         QueryResult result =  await client.mutate(
           MutationOptions(
             document: gql(new MutationGQL().invitEmployee(idEnt,email))
           )
         );
         return result;
 }
 updatePassword(String newPassword)async{
 GraphQLClient client = apiConnection.clientToQuery();
   
         QueryResult result =  await client.mutate(
           MutationOptions(
             document: gql(new MutationGQL().updatePassword(this, newPassword))
           )
         );
         return result;
}
updateUser()async{
 GraphQLClient client = apiConnection.clientToQuery();
   
         QueryResult result =  await client.mutate(
           MutationOptions(
             document: gql(new MutationGQL().updateUser(this))
           )
         );
         return result;
}
getUserById()async{
 GraphQLClient client = apiConnection.clientToQuery();
   
         QueryResult result =  await client.query(
           QueryOptions(
             document: gql(new QueryGQL().getUserById(this))
           )
         );
         return new User(result.data['getUserById']['id'],result.data['getUserById']['Nom'],result.data['getUserById']['Prenom'],result.data['getUserById']['Email'],result.data['getUserById']['Password'],result.data['getUserById']['Photo'].toString(),result.data['getUserById']['Phone'],null);
}
 }