import'package:gestion_commercial/Models/Client/ClientModel.dart';
import 'package:gestion_commercial/Models/Comptabilit%C3%A9/Compta.dart';
class QueryGQL{
String GetClients(ClientM client)=>"""query{
  GetClients(IdEnt:"${client.idEnt}"){
  id,Nom,Prenom,Email,Phone,Civility,Comment
  }}""";
String GetCompte(Compta compta)=>"""query{GetComptes(IdEnt:"${compta.idEntreprise}"){id,Numero,Debit,Credit,Resultat,Label}}""";


}