import 'dart:convert';

import'package:gestion_commercial/Models/Authentification/User.dart';
import'package:gestion_commercial/Models/Authentification/Plan.dart';
import 'package:gestion_commercial/Services/ApiConnection.dart';
import 'package:gestion_commercial/Services/Subscription/Mutation.dart';
import 'package:gestion_commercial/Services/Subscription/Query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart'as http;

class Abonnement {
ApiConnection apiconn=new ApiConnection();
String idSub;
  User entreprise;
  Plan plan;
  

  Abonnement({ this.entreprise, this.plan,this.idSub});

  getSubscriptions()async{
GraphQLClient client = apiconn.clientToQuery();
   
   var result= await client.query(
    QueryOptions(
      document:gql(new QueryGQL().getSubscriptions())
    )
    
  );
return result;
  
}
getSubscription()async{
GraphQLClient client = apiconn.clientToQuery();
   
   var result= await client.query(
    QueryOptions(
      document:gql(new QueryGQL().getSubscription(this.entreprise.ident))
    )
    
  );
return result;
  
}
checkSubscription()async{
GraphQLClient client = apiconn.clientToQuery();
   
   var result= await client.query(
    QueryOptions(
      document:gql(new QueryGQL().checkSubscription(this.entreprise.ident))
    )
    
  );
return result;
  
}
createSubscription()async{
GraphQLClient client = apiconn.clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().createSubscription(this.entreprise.ident,this.plan.id))
    )
    
  );
return result;
  
}
cancelSubscription()async{
GraphQLClient client = apiconn.clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().cancelSubscription(this.idSub))
    )
    
  );
return result;
  
}
 getIncome()async{

var url=Uri.https('sandbox.paymee.tn', '/api/v1/accounts/balance');
 var result=await http.get(url,
 headers: <String, String>{
      'Content-Type': 'application/json'
      ,'Authorization': 'Token a1f6ca8e3430713297131e9449c66ff4999b3e52'
    },
    );
    
    var y=json.decode(result.body);
    
   return( y['data']['balance']);
  
}
setid(String id){
  this.idSub=id;
}
  }
