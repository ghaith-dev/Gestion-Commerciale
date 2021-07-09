import 'package:gestion_commercial/Models/Client/ClientModel.dart';

class MutationGQL{

CreateClient(ClientM ClientM)=>"""mutation{CreateClient(Nom:"${ClientM.nom}",Prenom:"${ClientM.prenom}",Email:"${ClientM.email}",Phone:${ClientM.phone},Civility:"${ClientM.civility}",Comment:"${ClientM.comment}",IdEnt:"${ClientM.idEnt}")}""";
UpdateClient(ClientM ClientM)=>"""mutation{UpdateClient(IdClient:"${ClientM.id}",Nom:"${ClientM.nom}",Prenom:"${ClientM.prenom}",Email:"${ClientM.email}",Phone:${ClientM.phone},Civility:"${ClientM.civility}",Comment:"${ClientM.comment}")}""";
DeleteClient(ClientM ClientM)=>"""mutation{DeleteClient(IdClient:"${ClientM.id}")}""";
ClientSendail(ClientM Client,String object,String title)=>"""mutation{ClientSendMail(IdClient:"${Client.id}",Object:"${object}",Titel:"${title}")}""";
}
