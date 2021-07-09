import 'package:gestion_commercial/Models/Client/ClientModel.dart';
import 'package:gestion_commercial/Models/Comptabilit%C3%A9/Compta.dart';

class MutationGQL{

CreateCompte(Compta compta)=>"""mutation{CreateCompte(Numero:${compta.numero},IdEnt:"${compta.idEntreprise}",Label:"${compta.label}",Debit:${compta.debit},Credit:${compta.credit})}""";
Ecriture(Compta compta)=>"""mutation{EcritureComptable(Numero:"${compta.id}",Debit:${compta.debit},Credit:${compta.credit},IdEnt:"${compta.idEntreprise}")}""";
UpdateCompte(ClientM ClientM)=>"""mutation{DeleteClient(IdClient:"${ClientM.id}")}""";
}
