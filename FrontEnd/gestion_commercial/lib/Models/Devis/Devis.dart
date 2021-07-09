





import 'dart:ui';

import 'package:gestion_commercial/Models/Article/Article.dart';
import 'package:gestion_commercial/Models/Client/ClientModel.dart';
import 'package:gestion_commercial/Services/ApiConnection.dart';
import 'package:gestion_commercial/Services/Facturation/Mutation.dart';
import 'package:gestion_commercial/Services/Facturation/Query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

    

class DevisM extends ApiConnection{
  String id;
  int refDevis;
  String idClient;
  var articleList;
 var qtt;
 List<String> idArticles=[];
  double totaleTTC;
  ClientM cliente;
  String idEntreprise;
  bool selected;
DevisM({this.id,this.refDevis,this.articleList,this.qtt,this.totaleTTC,this.cliente,this.idEntreprise,this.selected,this.idArticles,this.idClient});

Future <List<DevisM> >GetStockState()async{

   GraphQLClient client = clientToQuery();
  
   var result= await client.query(
    QueryOptions(
      document:gql(new QueryGQL().GetDevis(this))
    )
  );
   

   List<DevisM>DevisList=[];
    
    List<int>quantList=[];
   DevisList.clear();

for(int i=0;i<result.data['GetDevis'].length;i++){
 
   DevisList.add(
     
     new DevisM(id:result.data['GetDevis'][i]['id'],
    refDevis: int.parse(result.data['GetDevis'][i]['refDevis'].toString()),
    cliente:new ClientM(id:result.data['GetDevis'][i]['Client']['id'] ,nom:result.data['GetDevis'][i]['Client']['Nom']),
    articleList: result.data['GetDevis'][i]['Articles'],
    qtt:result.data['GetDevis'][i]['qtt'],
    idEntreprise: idEntreprise,
    selected:false,
    
    
    totaleTTC: double.parse(result.data['GetDevis'][i]['TotaleTTC'].toString())
    ));
 
  
}
return DevisList;
}
 CreateDevis()async{
  GraphQLClient client = clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().CreateDevis(this))
    )
    
  );
return result;
  
}
 SendDevis()async{
  GraphQLClient client = clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().SendDevis(this))
    )
    
  );
return result;
  
}   

TransformerEnBonDeCommande()async{
  GraphQLClient client = clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().TransformerEnBonDeCommande(this))
    )
    
  );
return result;
}

 
} 



