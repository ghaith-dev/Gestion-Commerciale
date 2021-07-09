import 'package:gestion_commercial/Services/ApiConnection.dart';
import 'package:gestion_commercial/Services/Articles/Mutation.dart';
import 'package:gestion_commercial/Services/Articles/Query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ArticleM extends ApiConnection {
    String id;
    int ref;
    String label;
    double prixAchat;
    double prixVente;
    String idEntreprise;
ArticleM({this.id,this.label,this.prixAchat,this.prixVente,this.idEntreprise,this.ref});
Future <List<ArticleM> >GetArticle()async{

   GraphQLClient client = clientToQuery();
  
   var result= await client.query(
    QueryOptions(
      document:gql(new QueryGQL().GetArticles(this))
    )
  );

   List<ArticleM>ClientList=[];
   ClientList.clear();
for(int i=0;i<result.data['GetArticle'].length;i++){
 
    ClientList.add(new ArticleM(id:result.data['GetArticle'][i]['id'] 
    ,label: result.data['GetArticle'][i]['Label'].toString(),
    prixAchat: double.parse(result.data['GetArticle'][i]['PrixAchat'].toString())
    ,prixVente:double.parse(result.data['GetArticle'][i]['PrixVente'].toString()),
    idEntreprise:result.data['GetArticle'][i]['IdEnt']['id'],
    ref:int.parse(result.data['GetArticle'][i]['refArticle'].toString()) ));
  
}

return ClientList;
}

 

CreateArticle()async{
  GraphQLClient client = clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().CreateArticle(this))
    )
    
  );
return result;
  
}

DeleteArticle()async{
  GraphQLClient client = clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().DeleteClient(this))
    )
    
  );
return result;
  
}
UpdateClient()async{
  GraphQLClient client = clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().UpdateClient(this))
    )
    
  );
return result;
  
}

}

