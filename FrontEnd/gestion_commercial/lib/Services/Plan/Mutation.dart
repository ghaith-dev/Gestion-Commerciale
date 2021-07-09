import 'package:gestion_commercial/Models/Authentification/Plan.dart';

class MutationGQL{
  String createPlan(Plan plan)=>"""mutation{CreatePlan(planType:"${plan.planType}",prix:${plan.prix},duree:${plan.duree}){
    id,
    
  }}""";
String updatePlan(Plan plan)=>"""mutation{UpdatePlan(IdPlan:"${plan.id}",planType:"${plan.planType}",prix:${plan.prix},duree:${plan.duree})}""";
  String deletePlan(Plan plan)=>"""mutation {
  DeletePlan(
    IdPlan:"${plan.id}"
  
  )


}""";
}
