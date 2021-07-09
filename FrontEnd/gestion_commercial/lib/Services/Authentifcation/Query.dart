import 'package:gestion_commercial/Models/Authentification/User.dart';

class QueryGQL{
getPlans()=>"""

query{getPlans{id,planType,prix,duree}}


""";

checkRecovryCode(String email,int code)=>"""
query{checkRecovryCode(Email:"$email",Code:$code)}
""";
String getUserById(User user)=>"""query{getUserById(IdUser:"${user.id}"){
    id,Nom,Prenom,Email,Phone,Photo
}}""";
getUsers()=>"""
query{getUsers{
  id
  Nom
  Prenom
  Email
  Role{libelle}
  IdEnt{NomLegal}
  Phone
  IsVerified
  Suspended
}
}
""";
getUser(String email)=>"""
query{getUser(Email:"${email}"){
  id
  Nom
  Prenom
  Email
  Role{libelle}
  IdEnt{NomLegal}
  Phone
  IsVerified
  Suspended
}
}
""";

getEntreprises()=>"""query{getEntreprises{
  
  NomLegal,
  ,module{libelle},
  TypeDeCommerce,
  module{libelle},
  Phone,
  Email,
  Fax,
  Adresse,
   
  
}}""";
getEntreprise(String nom)=>"""query{getEntreprise(NomLegal:"${nom}"){
  
  NomLegal,
  ,module{libelle},
  TypeDeCommerce,
  module{libelle},
  Phone,
  Email,
  Fax,
  Adresse,
   
  
}}""";
getFirm(String idFirm)=>"""query{getFirm(idFirm:"${idFirm}"){NomLegal,module{libelle,SubModule},id,TypeDeCommerce,Phone,Email,Fax,Adresse,Logo,TypeDeCommerce}}""";
getEmployees(String idFirm)=>"""query{getEmployees(IdEnt:"${idFirm}"){id,Nom,Prenom,Email,Phone}}""";


}