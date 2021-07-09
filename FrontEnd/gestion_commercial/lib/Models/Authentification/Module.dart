import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:gestion_commercial/Services/ApiConnection.dart';
import'package:gestion_commercial/Services/Module/Query.dart';
import'package:gestion_commercial/Services/Module/Mutation.dart';


class Module{
    ApiConnection apiConnection = new ApiConnection();
 QueryResult result;
  String id ;
  String libelle;
List<String> submoduleList=[];
  Module(String id,String libelle,{this.submoduleList}){
    this.id=id;
    this.libelle=libelle;
    this.submoduleList=submoduleList;
    getModules();
 }
   getModules()async{
GraphQLClient client = apiConnection.clientToQuery();
   
   result= await client.query(
    QueryOptions(
      document:gql(new QueryGQL().getModules()),
      pollInterval: Duration(seconds: 2)
    )
    
  );
  return result;
  }
  createModules()async{
GraphQLClient client = apiConnection.clientToQuery();
   print(this.submoduleList.toString()+'fuck');
   result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().createModule(this)),
      
    )
    
  );
  
  return result;
  }
  updateModules()async{
GraphQLClient client = apiConnection.clientToQuery();
   
   result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().updatemodule(this)),
      
    )
    
  );
  
  return result;
  }
  
  setId(String id){
    this.id=id;
  }
}