import 'package:flutter/cupertino.dart';
import 'package:gestion_commercial/Models/Bon%20de%20Commande/Bon%20de%20Commande.dart';
import 'package:gestion_commercial/Models/Client/ClientModel.dart';
import 'package:gestion_commercial/Models/Commandes/Commande.dart';
import 'package:gestion_commercial/Models/Devis/Devis.dart';
import 'package:gestion_commercial/Screens/Commande/Commande.dart';

class MutationGQL{

CreateDevis(DevisM devis)=>"""mutation{CreateDevis(Articles:${devis.idArticles},Client:"${devis.idClient}",IdEnt:"${devis.idEntreprise}",Quant:${devis.qtt})}""";
SendDevis(DevisM devis)=>"""
mutation{SendDevisToClient(IdDevis:"${devis.id}")}
""";
TransformerEnBonDeCommande(DevisM devis)=>"""mutation{TrnsformBonDeCommande(IdDevis:"${devis.id}")}""";
CreateBonDeCommande(BonDeCommande bonDC)=>"""mutation{CreateDevis(Articles:${bonDC},Client:"${bonDC}",IdEnt:"${bonDC.idEntreprise}",Quant:${bonDC})}""";
SendBonDeCommande(BonDeCommande bonDC)=>"""
mutation{SendDevisToClient(IdDevis:"${bonDC.id}")}
""";
}

