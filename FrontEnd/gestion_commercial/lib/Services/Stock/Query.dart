import 'package:gestion_commercial/Models/Stock/Stock.dart';

class QueryGQL{

String getStockState(StockM stock)=>"""query{GetStockState(IdEnt:"${stock.idEntreprise}"){
  id,
  Article{id,refArticle,Label,PrixVente},
        Quant,
        IdEnt{id},
}}
""";

}