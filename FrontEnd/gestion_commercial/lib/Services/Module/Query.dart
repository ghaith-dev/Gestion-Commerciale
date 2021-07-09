import'package:gestion_commercial/Models/Authentification/Plan.dart';
class QueryGQL{
getModules()=>"""
query{getmoduls{id,libelle,SubModule}}
""";

}