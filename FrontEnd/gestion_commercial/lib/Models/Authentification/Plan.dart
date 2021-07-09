

import 'dart:convert';

import'package:gestion_commercial/Services/ApiConnection.dart';
import'package:gestion_commercial/Services/Plan/Query.dart';
import'package:gestion_commercial/Services/Plan/Mutation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart'as http;
class Plan {
  ApiConnection apiConnection = new ApiConnection();
  String id;
  String planType;
  double prix;
  int duree;
  QueryResult result ;
   var rsl;
 Plan(String id,String planType, double prix,int duree){
   this.id=id;
   this.planType=planType;
   this.prix=prix;
   this.duree=duree;
   this.getPalns();
   
 }

 
  getPalns()async{
GraphQLClient client = apiConnection.clientToQuery();
   
   result= await client.query(
    QueryOptions(
      document:gql(new QueryGQL().getPlans())
    )
    
  );
return result;
  
}
createPalns()async{
GraphQLClient client = apiConnection.clientToQuery();
   
   result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().createPlan(this))
    )
    
  );
return result;
  
}
updatePalns()async{
GraphQLClient client = apiConnection.clientToQuery();
   
   result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().updatePlan(this))
    )
    
  );
return result;
  
}
deletePalns()async{
GraphQLClient client = apiConnection.clientToQuery();
   
   result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().deletePlan(this))
    )
    
  );
return result;
  
}
 payerPlan()async{
   var url=Uri.https('sandbox.paymee.tn', '/api/v1/payments/create');
 var result=await http.post(url,
 headers: <String, String>{
      'Content-Type': 'application/json'
      ,'Authorization': 'Token a1f6ca8e3430713297131e9449c66ff4999b3e52'
    },
     body: json.encode({
      "vendor": 1785,
  "amount": this.prix,
  "note" : "${this.planType}"
    }),
    
    );
    var x=json.decode(result.body);
    return( x['data']['token']);
 }
 checkPayment(String token)async{
  
   var url=Uri.https('sandbox.paymee.tn', '/api/v1/payments/$token/check');
 var result=await http.get(url,
 headers: <String, String>{
      'Content-Type': 'application/json'
      ,'Authorization': 'Token a1f6ca8e3430713297131e9449c66ff4999b3e52'
    },
    );
    
    var y=json.decode(result.body);
    
   return( y['data']['payment_status']);
 }
}

