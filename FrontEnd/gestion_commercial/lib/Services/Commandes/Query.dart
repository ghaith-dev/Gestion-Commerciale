import'package:gestion_commercial/Models/Client/ClientModel.dart';
import 'package:gestion_commercial/Models/Commandes/Commande.dart';
class QueryGQL{

String GetCommandes(Commandes commande)=>"""query{GetCommende(IdEnt:"${commande.idEntreprise}"){id,Numero,TotalHT,TotalTTC,Article{Label,id,refArticle,PrixAchat,PrixVente,},Quant,Client{Nom}}}""";


}