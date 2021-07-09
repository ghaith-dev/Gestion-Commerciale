import 'package:gestion_commercial/Models/Fournisseur/FournissuerModel.dart';

class MutationGQL{

CreateFournissuer(FournisseurM FournisseurM)=>"""mutation{CreateFournisseur(Nom:"${FournisseurM.nom}",Prenom:"${FournisseurM.prenom}",NomEntreprise:"${FournisseurM.nomEntreprise}",Email:"${FournisseurM.email}",Phone:${FournisseurM.phone},Civility:"${FournisseurM.civility}",Comment:"${FournisseurM.comment}",IdEnt:"${FournisseurM.idEnt}")}""";
UpdateFournissuer(FournisseurM FournisseurM)=>"""mutation{UpdateFournisseur(IdFournisseur:"${FournisseurM.id}",Nom:"${FournisseurM.nom}",Prenom:"${FournisseurM.prenom}",NomEntreprise:"${FournisseurM.nomEntreprise}",Email:"${FournisseurM.email}",Phone:${FournisseurM.phone},Civility:"${FournisseurM.civility}",Comment:"${FournisseurM.comment}")}""";
DeleteFournissuer(FournisseurM FournisseurM)=>"""mutation{DeleteFournisseur(IdFournisseur:"${FournisseurM.id}")}""";
FournissuerSendail(FournisseurM FournisseurM,String object,String title)=>"""mutation{FournisseurSendMail(IdFournisseur:"${FournisseurM.id}",Object:"${object}",Titel:"${title}")}""";
}
