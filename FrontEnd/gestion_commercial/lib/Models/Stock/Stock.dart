import 'package:gestion_commercial/Models/Article/Article.dart';
import 'package:gestion_commercial/Services/ApiConnection.dart';
import 'package:gestion_commercial/Services/Stock/Mutation.dart';
import 'package:gestion_commercial/Services/Stock/Query.dart';
import'package:graphql_flutter/graphql_flutter.dart';
class StockM extends ApiConnection{
  String id;
  String idArticle;
  ArticleM article;
  int qtt;
  String idEntreprise;
  StockM({this.id,this.idArticle,this.qtt,this.article,this.idEntreprise});

Future <List<StockM> >GetStockState()async{

   GraphQLClient client = clientToQuery();
  
   var result= await client.query(
    QueryOptions(
      document:gql(new QueryGQL().getStockState(this))
    )
  );
   
print(result.data['GetStockState'].length);
   List<StockM>StockList=[];
   StockList.clear();

for(int i=0;i<result.data['GetStockState'].length;i++){
 print(result.data['GetStockState'].length);
   StockList.add(
     
     new StockM(id:result.data['GetStockState'][i]['id'] 
    ,
    article: new ArticleM(label: result.data['GetStockState'][i]['Article']['Label'],

    id: result.data['GetStockState'][i]['Article']['id'],

    ref: int.parse(result.data['GetStockState'][i]['Article']['refArticle'].toString()),

    prixVente: double.parse(result.data['GetStockState'][i]['Article']['PrixVente'].toString())
    ),
    idEntreprise: idEntreprise,
    qtt: int.parse(result.data['GetStockState'][i]['Quant'].toString())
    ));
 
  
}

return StockList;
}

 

AddArticleToStock()async{
  GraphQLClient client = clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().AddArticletoStock(this))
    )
    
  );
return result;
  
}

DeleteArticleFromStock()async{
  GraphQLClient client = clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().DeleteStockUnit(this))
    )
    
  );
return result;
  
}
UpdateArticleInStock()async{
  GraphQLClient client = clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().UpdateStockUnit(this))
    )
    
  );
return result;
  
}

}
