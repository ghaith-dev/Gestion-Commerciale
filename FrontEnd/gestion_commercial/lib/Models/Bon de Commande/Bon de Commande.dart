import 'package:gestion_commercial/Models/Client/ClientModel.dart';
import 'package:gestion_commercial/Models/Commandes/Commande.dart';
import 'package:gestion_commercial/Screens/Commande/Commande.dart';
import 'package:gestion_commercial/Services/ApiConnection.dart';
import 'package:gestion_commercial/Services/Facturation/Query.dart';
import 'package:graphql/client.dart';

class BonDeCommande extends ApiConnection{
String id;
  String refbondecommande;
  Commandes commende;
   ClientM clientc;
   var articles=[];
   String idEntreprise;
   BonDeCommande({this.refbondecommande,this.commende,this.clientc,this.idEntreprise,this.id,this.articles});
   GetBonDeCommande()async{

   GraphQLClient client = clientToQuery();
  
   var result= await client.query(
    QueryOptions(
      document:gql(new QueryGQL().GetBonDeCommandes(this))
    )
  );
   

   List<BonDeCommande>BonDeCommandeList=[];
    
    List<int>quantList=[];
   BonDeCommandeList.clear();


return result;
}

}