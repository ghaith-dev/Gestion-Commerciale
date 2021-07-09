import 'package:gestion_commercial/Models/Client/ClientModel.dart';
import 'package:gestion_commercial/Models/Commandes/Commande.dart';
import 'package:gestion_commercial/Screens/Commande/Commande.dart';

class MutationGQL{

CreateCommande(Commandes CommandeM)=>"""mutation{CreateCommende(Article:${CommandeM.articles},Quant:${CommandeM.quant},IdEnt:"${CommandeM.idEntreprise}",Client:"${CommandeM.cliente}")}""";
DeleteCommande(Commandes CommendeM)=>"""
mutation{DeleteCommende(Numero:${CommendeM.ref})}
""";

}
