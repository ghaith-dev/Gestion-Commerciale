import 'package:gestion_commercial/Services/ApiConnection.dart';
import 'package:gestion_commercial/Services/Fournissuer/Mutation.dart';
import 'package:gestion_commercial/Services/Fournissuer/Query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:gestion_commercial/Models/Fournisseur/FournissuerModel.dart';

class FournisseurM{
      ApiConnection apiConnection = new ApiConnection();

  String  id;
String  nom;
 String prenom;
String  email;
int  phone;
String idEnt;
 String civility;
 String comment;
 String nomEntreprise;
  FournisseurM({
this.id,
this.nom,
this.prenom,
this.email,
this.nomEntreprise,
this.phone,
this.civility,
 this.idEnt,
this.comment

  });
  Future <List<FournisseurM> >GetFournisseurs()async{

   GraphQLClient client = apiConnection.clientToQuery();
   var result= await client.query(
    QueryOptions(
      document:gql(new QueryGQL().GetFournisseurs(this))
    )
    
  );
   List<FournisseurM>FournisseurList=[];
   FournisseurList.clear();
for(int i=0;i<result.data['GetFournisseurs'].length;i++){
    FournisseurList.add(new FournisseurM(id:result.data['GetFournisseurs'][i]['id'] ,nom:result.data['GetFournisseurs'][i]['Nom'].toString(),prenom: result.data['GetFournisseurs'][i]['Prenom'],nomEntreprise: result.data['GetFournisseurs'][i]['NomEntreprise'],email:result.data['GetFournisseurs'][i]['Email'],phone:int.parse(result.data['GetFournisseurs'][i]['Phone'].toString()),civility: result.data['GetFournisseurs'][i]['Civility'],comment: result.data['GetFournisseurs'][i]['Comment']));
}

return FournisseurList;
}

 Future<List<FournisseurM>> GetFournisseur(String nom)async{

   GraphQLClient client = apiConnection.clientToQuery();
   var result= await client.query(
    QueryOptions(
      document:gql(new QueryGQL().GetFournisseur(nom,this))
    )
    
  );
   List<FournisseurM>FournisseurList=[];
   FournisseurList.clear();
for(int i=0;i<result.data['GetFournisseur'].length;i++){
    FournisseurList.add(new FournisseurM(id:result.data['GetFournisseur'][i]['id'] ,nom:result.data['GetFournisseur'][i]['Nom'].toString(),prenom: result.data['GetFournisseur'][i]['Prenom'],nomEntreprise: result.data['GetFournisseur'][i]['NomEntreprise'],email:result.data['GetFournisseur'][i]['Email'],phone:int.parse(result.data['GetFournisseur'][i]['Phone'].toString()),civility: result.data['GetFournisseur'][i]['Civility'],comment: result.data['GetFournisseur'][i]['Comment']));
}

return FournisseurList;
}

CreateFournisseur()async{
  GraphQLClient client = apiConnection.clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().CreateFournissuer(this))
    )
    
  );
return result;
  
}

DeleteFournisseur()async{
  GraphQLClient client = apiConnection.clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().DeleteFournissuer(this))
    )
    
  );
return result;
  
}
UpdateFournisseur()async{
  GraphQLClient client = apiConnection.clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().UpdateFournissuer(this))
    )
    
  );
return result;
  
}
SendMail(String sujet,String message)async{
  GraphQLClient client = apiConnection.clientToQuery();
   
   var result= await client.mutate(
    MutationOptions(
      document:gql(new MutationGQL().FournissuerSendail(this,sujet,message))
    )
    
  );
return result;
  
}
}