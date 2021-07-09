import 'package:flutter/cupertino.dart';
import 'package:gestion_commercial/Services/ApiConnection.dart';
import 'package:gestion_commercial/Services/Client/Mutation.dart';
import 'package:gestion_commercial/Services/Client/Query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ClientM {
    ApiConnection apiConnection = new ApiConnection();
    

String  id;
String  nom;
 String prenom;
String  email;
String idEnt;
int  phone;
 String civility;
 String comment;
  ClientM({
this.id,
this.nom,
this.prenom,
this.email,
this.phone,
this.civility,
this.comment,
 this.idEnt
  });

Future <List<ClientM> >GetClients()async{

   GraphQLClient client = apiConnection.clientToQuery();
   print('result');
   var result= await client.query(
    QueryOptions(
      document:gql(new QueryGQL().GetClients(this))
    )
    
  );
  
   List<ClientM>ClientList=[];
   ClientList.clear();
for(int i=0;i<result.data['GetClients'].length;i++){
    ClientList.add(new ClientM(id:result.data['GetClients'][i]['id'] ,nom:result.data['GetClients'][i]['Nom'].toString(),prenom: result.data['GetClients'][i]['Prenom'],email:result.data['GetClients'][i]['Email'],phone:int.parse(result.data['GetClients'][i]['Phone'].toString()),civility: result.data['GetClients'][i]['Civility'],comment: result.data['GetClients'][i]['Comment']));
}

return ClientList;
}

 Future<List<ClientM>> GetClient(String nom)async{

   GraphQLClient client = apiConnection.clientToQuery();
   var result= await client.query(
    QueryOptions(
      document:gql(new QueryGQL().GetClient(nom,this))
    )
    
  );
  print(this.idEnt);
   List<ClientM>ClientList=[];
   ClientList.clear();
for(int i=0;i<result.data['GetClient'].length;i++){
    ClientList.add(new ClientM(id:result.data['GetClient'][i]['id'] ,nom:result.data['GetClient'][i]['Nom'].toString(),prenom: result.data['GetClient'][i]['Prenom'],email:result.data['GetClient'][i]['Email'],phone:int.parse(result.data['GetClient'][i]['Phone'].toString()),civility: result.data['GetClient'][i]['Civility'],comment: result.data['GetClient'][i]['Comment']));
}

return ClientList;
}

CreateClient()async{
  GraphQLClient client = apiConnection.clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().CreateClient(this))
    )
    
  );
return result;
  
}

DeleteClient()async{
  GraphQLClient client = apiConnection.clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().DeleteClient(this))
    )
    
  );
return result;
  
}
UpdateClient()async{
  GraphQLClient client = apiConnection.clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().UpdateClient(this))
    )
    
  );
return result;
  
}
SendMail(String sujet,String message)async{
  GraphQLClient client = apiConnection.clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().ClientSendail(this,sujet,message))
    )
    
  );
return result;
  
}
}

