import'package:gestion_commercial/Models/Client/ClientModel.dart';
class QueryGQL{
String GetClients(ClientM client)=>"""query{
  GetClients(IdEnt:"${client.idEnt}"){
  id,Nom,Prenom,Email,Phone,Civility,Comment
  }}""";
String GetClient(String nom,ClientM client)=>"""query{GetClient(Nom:"${nom}",IdEnt:"${client.idEnt}"){id,Nom,Prenom,Email,Phone,Civility,Comment}}""";


}