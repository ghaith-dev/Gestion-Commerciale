import'package:gestion_commercial/Services/ApiConnection.dart';
import'package:gestion_commercial/Services/Authentifcation/Mutation.dart';
import'package:gestion_commercial/Services/Authentifcation/Query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
class Entreprise {
String id;
String nomLegal;
String typeDeCommerce;
List<String> module ;
int phone;
String email;
int fax;
String adresse;


ApiConnection apiConnection = new ApiConnection();
  Entreprise(String id ,String nomLegal,String typeDeCommerce,List<String> module,int phone,String email,int fax,String adresse){
    this.id=id;
    this.nomLegal=nomLegal;
    this.typeDeCommerce=typeDeCommerce;
    this.module=module;
    this.phone=phone;
    this.email=email;
    this.fax=fax;
    this.adresse=adresse;
   
  }
  creatEntrprise()async{
    GraphQLClient client = apiConnection.clientToQuery();
   
         QueryResult result =  await client.mutate(
           MutationOptions(
             
             document: gql(new MutationGQL().creatEntreprise(this.nomLegal, this.typeDeCommerce,this.module, this.phone, this.email, this.fax, this.adresse, "logoent.jpg"))
           )
         );
         return result;

  }
  void setid(String id){
    this.id=id;
  }
  getEntreprises()async{
    GraphQLClient client = apiConnection.clientToQuery();
   
         QueryResult result =  await client.query(
           QueryOptions(
             
             document: gql(new QueryGQL().getEntreprises())
           )
         );
         return result;
  }
  getEntreprise(String nom)async{
    GraphQLClient client = apiConnection.clientToQuery();
   
         QueryResult result =  await client.query(
           QueryOptions(
             
             document: gql(new QueryGQL().getEntreprise(nom))
           )
         );
         return result;
  }
  getfirm(String idFirm)async{
    GraphQLClient client = apiConnection.clientToQuery();
   
         QueryResult result =  await client.query(
           QueryOptions(
             
             document: gql(new QueryGQL().getFirm(idFirm))
           )
         );
         return result;
  }
}