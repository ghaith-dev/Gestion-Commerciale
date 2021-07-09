import 'package:gestion_commercial/Models/Authentification/Module.dart';

class MutationGQL{
  String createModule(Module module)=>"""mutation{CreatModule(libelle:"${module.libelle}",SubModule:${module.submoduleList}){id}}
   """;
String updatemodule(Module module)=>"""mutation{UpdateModule(libelle:"${module.libelle}",IdModule:"${module.id}")}""";
 
}
