import 'package:gestion_commercial/Models/Authentification/User.dart';

class MutationGQL{
  String creatUser( String nom ,String prenom,String email,int phone,String password,String role, String photo)=>"""
 
  mutation {CreatUser(Nom:"$nom",Prenom:"$prenom",Email:"$email",Phone:$phone,Password:"$password",Role:"$role",Photo:"$photo"){
    token,
    Msg,
     user{
      id,
      Nom,
      Prenom,
      Email,
      Password,
      Phone,
      
      Photo
      
    }
    
  }}
 
 """;
 String getVerified(String idUser,int code)=>"""mutation{
  getVerified(IdUser:"$idUser",Code:$code)
    
  
}""";
String resendCode(String idUser)=>"""mutation{ResendCode(IdUser:"$idUser")}""";
String creatEntreprise(String nomLegal,String typeCommerce,List<String>module,int phone,String email,int fax,String adresse,String logo)=>"""mutation {
CreateEntreprise(NomLegal:"$nomLegal",TypeDeCommerce:"$typeCommerce",module:$module,Phone:$phone,Email:"$email",Fax:$fax,Adresse:"$adresse",Logo:"$logo"){
  id
  NomLegal,
  TypeDeCommerce,
  Phone
  Email,
  Adresse,
  Logo
  
  
}
}""";
String setIdEnt(String idEnt,String idUser)=>"""mutation{SetIdEnt(IdUser:"${idUser}",IdEnt:"${idEnt}"){id,IdEnt{id,NomLegal}}}""";
String updatePassword (User user,String  newPassword)=>"""mutation{UpdatePassword(IdUser:"${user.id}",Password:"${newPassword}",oldPassword:"${user.password}")}""";
String updateUser(User user)=>"""mutation{UpdateUser(IdUser:"${user.id}",Nom:"${user.nom}",Prenom:"${user.prenom}",Email:"${user.email}",Phone:${user.phone},Photo:"${user.photo}")}

""";
String invitEmployee(String idEnt,String email)=>"""mutation{InviteUser(IdEnt:"${idEnt}",Email:"${email}")}

""";

String generatePasswordRecovryCode(String email)=> """mutation{GeneratePasswordRecovryCode(Email:"$email")}""";
String passwordRecovry(String email,String password)=>"""mutation{PasswordRecovry(Email:"${email}",Password:"${password}")}""";
String login(String email,String password)=>"""mutation{Login(Email:"${email}",Password:"${password}"){token,user{id,Nom,Email,Prenom,Photo,Photo,Phone,Role{id,libelle},IdEnt{id}},Msg}}""";
String suspendUser(String idUser,int stat)=> """mutation{SuspendUser(IdUser:"${idUser}",Stat:${stat})}""";
}
