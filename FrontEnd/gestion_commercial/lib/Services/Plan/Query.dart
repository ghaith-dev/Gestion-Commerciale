import'package:gestion_commercial/Models/Authentification/Plan.dart';
class QueryGQL{
getPlans()=>"""

query{getPlans{id,planType,prix,duree}}


""";

}