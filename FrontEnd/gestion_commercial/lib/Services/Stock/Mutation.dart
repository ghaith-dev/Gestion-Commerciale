import 'package:gestion_commercial/Models/Stock/Stock.dart';

class MutationGQL{
  String AddArticletoStock(StockM stock)=>"""mutation{AddArticle(Article:"${stock.idArticle}",Quant:${stock.qtt},IdEnt:"${stock.idEntreprise}")
 }""";
   String UpdateStockUnit(StockM stock)=>"""mutation{UpdateStockUnit(IdUnit:"${stock.id}",Quant:"${stock.qtt}")}
 """;
      String DeleteStockUnit(StockM stock)=>"""mutation{DeleteStockUnit(IdUnit:"${stock.id}")}
 """;  
   


}
