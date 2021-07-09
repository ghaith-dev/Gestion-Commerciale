class MutationGQL{
  String createSubscription(String userId,String planId)=>"""mutation{CreateSubscription(user:"${userId}",plan:"${planId}"){
  id
  user{id,NomLegal,Email},
  plan{id,planType,duree}
  date
}}""";

String cancelSubscription(String idSub)=>"""mutation{CancelSubscription(IdSub:"${idSub}")}""";

}
