import 'package:gestion_commercial/Models/Article/Article.dart';
import'package:gestion_commercial/Models/Client/ClientModel.dart';
class QueryGQL{
String GetArticles(ArticleM article)=>"""query{
  GetArticle(Label:"${article.label}",IdEnt:"${article.idEntreprise}"){
    id,Label,PrixAchat,PrixVente,IdEnt{id,NomLegal},refArticle}}
  """;



}