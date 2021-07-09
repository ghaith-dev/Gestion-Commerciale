import 'package:gestion_commercial/Models/Article/Article.dart';
import 'package:gestion_commercial/Services/ApiConnection.dart';
import 'package:gestion_commercial/Services/Commandes/Mutation.dart';
import 'package:gestion_commercial/Services/Commandes/Query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Commandes extends ApiConnection{
String id;
int ref;
  int totalHt;
  int totalTTC;
  List<String>articles;
    List<ArticleM>articlesM;

  String cliente;
  List<int>quant;
  bool selected;
  String idEntreprise;
  Commandes({this.id,this.ref,this.totalHt,this.totalTTC,this.articles,this.cliente,this.quant,this.idEntreprise,this.selected,this.articlesM});
  fillarticles(int count,var x){
        List<ArticleM>ArticlesList=[];

    for(int i;i<count;i++){
     for(int j;j<x.data['GetCommende'][i]['Article'].length;j++){ 
ArticlesList.add(new ArticleM(id:x.data['GetCommende'][i]['Article'][j]['id'],ref:x.data['GetCommende'][i]['Article'][j]['refArticle'],label:x.data['GetCommende'][i]['Article'][j]['Label'],prixVente: x.data['GetCommende'][i]['Article'][j]['PrixVente']));
    }}
return ArticlesList;
  }
   /*fillquant(int count,var x){
        List<ArticleM>ArticlesList=[];

    for(int i;i<count;i++){
     for(int j;j<x.data['GetCommende'][i]['Article'].length;j++){ 
ArticlesList.add(new ArticleM(id:x.data['GetCommende'][i]['Article'][j]['id'],ref:x.data['GetCommende'][i]['Article'][j]['refArticle'],label:x.data['GetCommende'][i]['Article'][j]['Label'],prixVente: x.data['GetCommende'][i]['Article'][j]['PrixVente']));
    }}

  }*/
Future <List<Commandes> >GetStockState()async{

   GraphQLClient client = clientToQuery();
  
   var result= await client.query(
    QueryOptions(
      document:gql(new QueryGQL().GetCommandes(this))
    )
  );
   

   List<Commandes>CommandesList=[];
    List<ArticleM>ArticlesList=[];
    List<String>ArticleIDList=[];
    List<int>quantList=[];
   CommandesList.clear();

for(int i=0;i<result.data['GetCommende'].length;i++){
 
   CommandesList.add(
     
     new Commandes(id:result.data['GetCommende'][i]['id'],
    ref: int.parse(result.data['GetCommende'][i]['Numero'].toString()),
    cliente:result.data['GetCommende'][i]['Client']['Nom'],
    idEntreprise: idEntreprise,
    selected:false,
    
    totalHt: int.parse(result.data['GetCommende'][i]['TotalHT'].toString()),
    totalTTC: int.parse(result.data['GetCommende'][i]['TotalTTC'].toString())
    ));
 
  
}

return CommandesList;
}
    CreateCommande()async{
  GraphQLClient client = clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().CreateCommande(this))
    )
    
  );
return result;
  
}  
DeleteCommande()async{
  GraphQLClient client = clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().DeleteCommande(this))
    )
    
  );
return result;
  
}   
void setSelected(bool xhk){
  this.selected=xhk;
}
}