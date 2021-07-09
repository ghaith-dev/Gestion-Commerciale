import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";

class ApiConnection {
  final HttpLink httpLink = HttpLink('http://192.168.1.13:3000/graphql');

 final ValueNotifier<GraphQLClient> client = new  ValueNotifier<GraphQLClient>(
      GraphQLClient(
      link:HttpLink('http://192.168.1.13:3000/graphql'),
          cache:GraphQLCache(),
          
          
 
      )
    );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );
  }
}