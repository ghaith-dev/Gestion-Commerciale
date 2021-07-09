import'package:gestion_commercial/Models/Fournisseur/FournissuerModel.dart';
class QueryGQL{
String GetFournisseurs(FournisseurM fournisseur)=>"""query{
  GetFournisseurs(IdEnt:"${fournisseur.idEnt}"){
  id,Nom,Prenom,Email,Phone,Civility,Comment,NomEntreprise
  }}""";
String GetFournisseur(String nom,FournisseurM fournisseur)=>"""query{GetFournisseur(Nom:"${nom}",IdEnt:"${fournisseur.idEnt}"){id,Nom,Prenom,Email,Phone,Civility,Comment,NomEntreprise}}""";


}