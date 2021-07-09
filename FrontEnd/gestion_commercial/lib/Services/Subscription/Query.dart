class QueryGQL{
 String checkSubscription(String idEnt)=>"""query{checkSubscription(Entr:"${idEnt}")}""";
String getSubscriptions()=>"""query{getSubscriptions{
  id,
  user{id,NomLegal,Email},
  plan{id,planType,duree,prix},
  date
}}
""";
String getSubscription(String idEntr)=>"""query{getSubscription(id:"${idEntr}"){
  id
  user{id,NomLegal,Email},
  plan{id,planType,prix,duree}
  date
}}
""";
}
