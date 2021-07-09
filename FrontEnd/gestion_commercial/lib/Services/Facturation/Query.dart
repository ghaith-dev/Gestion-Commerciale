import 'package:gestion_commercial/Models/Bon%20de%20Commande/Bon%20de%20Commande.dart';
import'package:gestion_commercial/Models/Client/ClientModel.dart';
import 'package:gestion_commercial/Models/Commandes/Commande.dart';
import 'package:gestion_commercial/Models/Devis/Devis.dart';
class QueryGQL{

String GetDevis(DevisM devis)=>"""query{GetDevis(IdEnt:"${devis.idEntreprise}"){id,refDevis,Articles{id,refArticle,Label,PrixAchat,PrixVente,}TotaleTTC,qtt,Client{id,Nom,Prenom,Email}}}""";

String GetBonDeCommandes(BonDeCommande bonDC)=>"""query{GetBonDeCommande(IdEnt:"${bonDC.idEntreprise}"){id,refBonDC,
  Commande{id,Numero,TotalTTC,Article{id,refArticle,Label,PrixVente}
    ,Quant,
  }
  Client{id,Nom,Prenom}
}
}""";
}




