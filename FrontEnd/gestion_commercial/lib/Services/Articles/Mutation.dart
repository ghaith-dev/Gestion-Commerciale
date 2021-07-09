import 'package:gestion_commercial/Models/Article/Article.dart';
import 'package:gestion_commercial/Models/Client/ClientModel.dart';

class MutationGQL{

CreateArticle(ArticleM ArticleM)=>"""mutation{CreateArticle(Label:"${ArticleM.label}",PrixAchat:${ArticleM.prixAchat},PrixVente:${ArticleM.prixVente},IdEnt:"${ArticleM.idEntreprise}")}""";
UpdateClient(ArticleM ArticleM)=>"""mutation{UpdateArticle(IdArticle:"${ArticleM.id}",Label:"${ArticleM.label}",PrixAchat:${ArticleM.prixAchat},PrixVente:${ArticleM.prixVente},IdEnt:"${ArticleM.idEntreprise}")}""";
DeleteClient(ArticleM ArticleM)=>"""mutation{DeleteArticle(IdArticle:"${ArticleM.id}")}""";

}
