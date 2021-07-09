import 'package:gestion_commercial/Services/ApiConnection.dart';
import 'package:gestion_commercial/Services/Comptabilité/Mutation.dart';
import 'package:gestion_commercial/Services/Comptabilit%C3%A9/Query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Compta extends ApiConnection{
  var idEntreprise;
  String id;
  int numero;
  String label;
  double debit;
  double credit;
  double resultat;
Compta({this.id,this.numero,this.label,this.debit,this.credit,this.resultat,this.idEntreprise});
Future <List<Compta> >GetComptes()async{

   GraphQLClient client = clientToQuery();
  
   var result= await client.query(
    QueryOptions(
      document:gql(new QueryGQL().GetCompte(this))
    )
  );

   List<Compta>ComptaList=[];
   ComptaList.clear();
for(int i=0;i<result.data['GetComptes'].length;i++){
 
    ComptaList.add(new Compta(id:result.data['GetComptes'][i]['id'] ,
    numero: int.parse(result.data['GetComptes'][i]['Numero'].toString())
    ,label: result.data['GetComptes'][i]['Label'].toString(),
    credit:  double.parse(result.data['GetComptes'][i]['Credit'].toString())
    ,debit:double.parse(result.data['GetComptes'][i]['Debit'].toString()),
    idEntreprise:result.data['GetComptes'][i]['IdEnt'].toString(),
    resultat:double.parse(result.data['GetComptes'][i]['Resultat'].toString())
     ));
  
}

return ComptaList;
}

 

EcritureComptable()async{
  GraphQLClient client = clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().Ecriture(this))
    )
    
  );
return result;
  
}
CreerCompte()async{
  GraphQLClient client = clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().CreateCompte(this))
    )
    
  );
return result;
  
}
}