import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_commercial/Models/Article/Article.dart';
import 'package:gestion_commercial/Models/Client/ClientModel.dart';
import 'package:gestion_commercial/Models/Commandes/Commande.dart';
import 'package:gestion_commercial/Models/Devis/Devis.dart';
import 'package:gestion_commercial/Models/Stock/Stock.dart';
import 'package:gestion_commercial/Screens/Facturation/Bon%20de%20Livrison.dart';
import 'package:gestion_commercial/Screens/Facturation/Facture.dart';
import 'package:gestion_commercial/Screens/Super-Admin/Style/TextStyle.dart';
import 'package:gestion_commercial/Screens/User/UserNavDrawer.dart';
import'package:gestion_commercial/main.dart'as main;
import 'package:dropdown_search/dropdown_search.dart';


import '../../Responsive.dart';
import 'Bon de commande.dart';
class Facturation extends StatefulWidget {
var idEntreprise;
Facturation({this.idEntreprise});
  @override
  _FacturationState createState() => _FacturationState();
}

class _FacturationState extends State<Facturation> {
  
  @override
  var idclient;
  List<String> slectedArticles=[];
    List<String> slectedCommandes=[];
    List<int> selectedIndexes=[];
    List<String> stockslectedArticles=[];
    List<int> selectedQtt=[];
  var _ischercher=false;
                    var  _switchsource=true;
                     ArticleM article ;
                     StockM stockUnit;
                       Commandes commande;
                       DevisM devis;

                    List<bool> checkboxvaluses=[];
                    List<bool> stockcheckboxvaluses=[];
                   List<TextEditingController> qttControllers=[]; 
 List<ArticleM>articleList=[];
 List<DevisM>devisList=[];
  List<Commandes>commendaesList=[];

  List<StockM>stockUnitsList=[];
 fillCheckboxValues(int count){
   List<bool> cbvalues=[];
 
 for (int i=0;i<count;i++){
cbvalues.add(false);
print(i);
 }
    
return(cbvalues);
 
}
 fillConrolleurs(int count){
   List<TextEditingController> cbvalues=[];
 
 for (int i=0;i<count;i++){
cbvalues.add(new TextEditingController(text: '1'));
print(i);
 }
    
return(cbvalues);
 
}
TextEditingController qttController= new TextEditingController();
Future <int> _getcount()async{
  int z;
  article= new ArticleM(idEntreprise: widget.idEntreprise,label: "");
   articleList.clear();
   

  var x =await article.GetArticle();
      
    return x.length;
  
    
}
Future <int> _getcountStock()async{
  int z;
  StockM stock = new StockM(idEntreprise: widget.idEntreprise);
   articleList.clear();
   

  var x =await stock.GetStockState();
      
    return x.length;
  
    
}
 Future <void> _initData() async {
  
article= new ArticleM(idEntreprise: widget.idEntreprise,label: "");
   commendaesList.clear();
   articleList.clear();
   stockUnitsList.clear();

  stockUnit=new StockM(idEntreprise: widget.idEntreprise);
 commande=new Commandes(idEntreprise: widget.idEntreprise);
 var z= await commande.GetStockState();
 commendaesList=z;
 var y = await stockUnit.GetStockState();
      print('aa');
  stockUnitsList=y;

  var x =await article.GetArticle();
    devis=new DevisM(idEntreprise: widget.idEntreprise);
    var t=  await devis.GetStockState();  
   devisList=t;
    
  
    articleList=x;
  
     
   
    
     
     
  }

  Widget nav;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
 
_getcount().then((value) => 
checkboxvaluses.addAll( fillCheckboxValues(value))
);
_getcountStock().then((value) {
stockcheckboxvaluses.addAll( fillCheckboxValues(value));

qttControllers.addAll(fillConrolleurs(value));


});
  


    nav=UserNavDrawer(z:widget.idEntreprise);


  
      

 print(articleList.toString()+'dd');
  }
  @override
  Widget build(BuildContext context) {
    return    DefaultTabController(
          length: 4,
          child: Scaffold(
      resizeToAvoidBottomInset:false,
        appBar:  AppBar(backgroundColor: Colors.white, title:Responsive.isMobile(context)? Text('Facturation ',style:TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'Barlow')):null,elevation: 0.0,bottom: TabBar(tabs: [
          Text('Devis',style: Responsive.isDesktop(context)? Textstyle():TextStyle(fontSize:14,fontFamily: 'Barlow',color: Colors.black,))
          ,Text('Bon De commande',style: Responsive.isDesktop(context)? Textstyle():TextStyle(fontSize:14,fontFamily: 'Barlow',color: Colors.black,))
          ,Text('Facture',style: Responsive.isDesktop(context)? Textstyle():TextStyle(fontSize:14,fontFamily: 'Barlow',color: Colors.black,))
          ,Text('Bon de livraison',style: Responsive.isDesktop(context)? Textstyle():TextStyle(fontSize:14,fontFamily: 'Barlow',color: Colors.black,))
          ],),leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu_rounded,color: Colors.black,size: 40.0,),
            onPressed: () => Scaffold.of(context).openDrawer(),

          ), )),
           drawer: Responsive.isMobile(context)==true ?Container(
          child: nav,
          width: MediaQuery.of(context).size.width*0.65,
          ):null,
        body:(Responsive.isDesktop(context))? Row(
          children: [
            Expanded(flex:1,child: Container(child:nav,)),
            Expanded(flex:5,child: Container(color: Colors.primaryColor,child: CommandesTable(),))
          ],
        ) :
        Container(color: Colors.white,child: StockTableMobile())
      ),
    ); 
    
  }
  
  
  Widget StockTableMobile(){
    return FutureBuilder(
        future:_initData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
             
        return   PageView(
          children: [
CommandesTable(),

          ],
        );});
  }

  Widget CommandesTable(){
     

    return TabBarView(
          
          children: [
          FutureBuilder(
          future:_initData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
               
          return   Container(
          child:Column(
            children: [
              Expanded(flex:1 ,child: Container(color: Colors.white,
              
              child:Row(children: [
               Expanded(
                  flex: 3,
                  child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Text('Devis',style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold, fontFamily: 'Barlow')),
                )),
               Spacer(flex:1),
Expanded( flex:3 ,child: Container(
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                   
                  ),
                  
                  child: TextField(
decoration: 
                    InputDecoration(
                      hintText: 'Id Devis',
                      
                      prefixIcon: _ischercher ? InkWell(onTap: (){
                        setState(() {
                          _ischercher=false;
                          _switchsource=true;
                          
                          FocusScope.of(context).unfocus();
                          
                        });
                        
                      },child: Icon(Icons.cancel,color: Colors.primaryColor))
                      : null,
                      fillColor: Colors.white70,
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.primaryColor )),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.primaryColor ))
                      ,suffixIcon:InkWell(onTap:() {
setState(() {
  _switchsource=true;
});
                      },child: Icon(Icons.search_rounded,color: Colors.primaryColor,)) )
                  )))
              ],)
                        )
                 ),
                 
              Expanded(
                flex: 4,
                          child: Row(children: [
                  Expanded(flex:1 ,child: Column(
                    
                    children: [
                 Expanded(flex:2,child: Container(color: Colors.white,child:Column(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(left:8.0),
                           child: Text('Les Devis',style:TextStyle(fontSize: 19,fontWeight: FontWeight.bold, fontFamily: 'Barlow')),
                         ),
                       ],
                       
                     ),
                     Row(
                      
                       children: [
                       
Padding(
  padding: const EdgeInsets.only(left:8.0),
  child:   ElevatedButton.icon( onPressed: () { 
      
Navigator.push(context, MaterialPageRoute(builder: (context)=>showEditDialog()));

   },icon: Icon(Icons.add), label:Text ('Editer Devis'),style: ElevatedButton.styleFrom(primary: Colors.primaryColor )),
),


                 ],)

                   ],
                 ))),
                 Expanded(flex:5,child: Container(color: Colors.white,
                 child: SizedBox(
              width: double.infinity,
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                                          child: DataTable(columnSpacing: 20, columns: [
                                                        
                     DataColumn(label: Text('id', ),),
                    DataColumn(label: Text('Totale TTC',),),
                    DataColumn(label: Text('Client',)),
                    DataColumn(label: Text('*',)),

                   
                    



              ],
              rows: [
               
               
                 
              for (int i=0;i<devisList.length;i++) 
      
              DataRow(cells: [
                    
                
                      
               
                 DataCell( SizedBox( width: double.infinity,child:Text(devisList[i].refDevis.toString(),style:Responsive.isDesktop(context)? Textstyle():TextStyle(fontFamily: 'Barlow',fontSize: 18)) ),),
                DataCell( SizedBox( width: double.infinity,child:Text(devisList[i].totaleTTC.toString(),style:Responsive.isDesktop(context)? Textstyle():TextStyle(fontFamily: 'Barlow',fontSize: 18))) ),
                DataCell( SizedBox( width: double.infinity,child:Text(devisList[i].cliente.nom.toString(),style:Responsive.isDesktop(context)? Textstyle():TextStyle(fontFamily: 'Barlow',fontSize: 18))) ),
               DataCell( SizedBox( width: double.infinity,
               child:Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween
                 ,children: [
                   Padding(
                     padding: const EdgeInsets.only(right:8.0),
                     child: ElevatedButton.icon(onPressed: ()async{
                  showDevis(context,devisList[i]);
                      
                    


                 }, icon: Icon(Icons.description_sharp), label:Text ('Consulter '),style: ElevatedButton.styleFrom(primary: Colors.primaryColor )),
                   ),
                 ElevatedButton.icon(onPressed: ()async{
                  DevisM devis = new DevisM(idEntreprise: widget.idEntreprise,id:devisList[i].id);
                     var x=await devis.SendDevis();
                   if(x.data['SendDevisToClient']){
                         
                         
                         showDialog(context: context, builder: (context)=>AlertDialog(content: Text('Devis Envoyer avec succés',style: Textstyle(),),actions: [FlatButton(onPressed: ()=>{
                           Navigator.pop(context)
                         }, child: Text('Ok'))],));
                       }
                      else{
                         showDialog(context: context, builder: (context)=>AlertDialog(content: Container(height:50 ,child: Text('vérifier votre donnés'),)));
                      }


                 }, icon: Icon(Icons.send), label:Text ('Envoyer a Client '),style: ElevatedButton.styleFrom(primary: Colors.primaryColor )),
                 Padding(
                   padding: const EdgeInsets.only(left:8.0),
                   child: ElevatedButton.icon(onPressed: ()async{
                     DevisM devis = new DevisM(idEntreprise: widget.idEntreprise,id:devisList[i].id);
                       var x=await devis.TransformerEnBonDeCommande();
                     if(x.data['TrnsformBonDeCommande']){
                           
                           
                           showDialog(context: context, builder: (context)=>AlertDialog(content: Text('Votre devis et transformé en bon de commande avec succsé',style: Textstyle(),),actions: [FlatButton(onPressed: ()=>{
                             Navigator.pop(context)
                           }, child: Text('Ok'))],));
                         }
                        else{
                           showDialog(context: context, builder: (context)=>AlertDialog(content: Container(height:50 ,child: Text('vérifier votre donnés'),)));
                        }

                   }, icon: Icon(Icons.transform_rounded), label:Text ('Transformé en Bon de commande',),style: ElevatedButton.styleFrom(primary: Colors.blue[900] )),
                 ),
                                
                 
                 
                 ],) ),)
                 ,
                 
               
                ])
          
                ])
          ),
                              ),)
),
                 
                 
                 
                 ))
                 ],)
                  
                  
                  
                  
                  ),
                  
                 
                ],),
              ),
            ],
          )
        );
            }),
            BonDeCommandeTable(idEntreprise:  widget.idEntreprise),
            FactureTable(idEntreprise:  widget.idEntreprise),
            BonDeLivraisonTable(idEntreprise:  widget.idEntreprise),
          ]);
  }
  showDevis(BuildContext context,DevisM devis){
    return showDialog(context: context, builder: (context)=>AlertDialog(
    content: SizedBox(
              width: double.infinity,
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                                          child: DataTable(columnSpacing: 5, columns: [
                                                        
                     DataColumn(label: Text('ref', ),),
                    DataColumn(label: Text('Label',),),
                    DataColumn(label: Text('qté',)),
                    DataColumn(label: Text('PU',)),
                    DataColumn(label: Text('Totale',)),
                   

                   
                    



              ],
              rows: [
               
               
                 
               
      for (int j=0;j<devis.articleList.length;j++)
              DataRow(cells: [
                    
                
                      
               
                 DataCell( SizedBox( width: double.infinity,child:Text(devis.articleList[j]['refArticle'].toString(),style:Responsive.isDesktop(context)? Textstyle():TextStyle(fontFamily: 'Barlow',fontSize: 18)) ),),
                  
                DataCell( SizedBox( width: double.infinity,child:Text(devis.articleList[j]['Label'].toString(),style:Responsive.isDesktop(context)? Textstyle():TextStyle(fontFamily: 'Barlow',fontSize: 18))) ),
                DataCell( SizedBox( width: double.infinity,child:Text(devis.qtt[j].toString(),style:Responsive.isDesktop(context)? Textstyle():TextStyle(fontFamily: 'Barlow',fontSize: 18))) ),
               DataCell( SizedBox( width: double.infinity,child:Text(devis.articleList[j]['PrixVente'].toString(),style:Responsive.isDesktop(context)? Textstyle():TextStyle(fontFamily: 'Barlow',fontSize: 18))) ),
                DataCell( SizedBox( width: double.infinity,child:Text("${(int.parse(devis.articleList[j]['PrixVente'].toString())*(int.parse(devis.qtt[j].toString())))}",style:Responsive.isDesktop(context)? Textstyle():TextStyle(fontFamily: 'Barlow',fontSize: 18))) ),
                 
                 
               
                ])
          
                ])
          ),
                              ),)
),


    ));
  }
  StatefulWidget showEditDialog(){
    return Scaffold(
          body: SafeArea(
                      child: StatefulBuilder(
              builder: ( context, setState) {  
              return AlertDialog(
                content:Column(
  
              children: [
  
              Padding(
  
              padding: const EdgeInsets.only(left:8.0),
  
              child: Text('Nouveau Devis',style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold, fontFamily: 'Barlow')),
  
               ),
  
              
  
               Container(
  
                 
  
                 decoration: BoxDecoration(
  
                   borderRadius: BorderRadius.circular(5),
  
                   color: Colors.white,
  
                  
  
                 ),
  
                 
  
                 child: TextField(
  
              decoration: 
  
                   InputDecoration(
  
                     hintText: 'Id Article',
  
                     
  
                     prefixIcon: _ischercher ? InkWell(onTap: (){
  
                       setState(() {
  
                         _ischercher=false;
  
                         _switchsource=true;
  
                         
  
                         FocusScope.of(context).unfocus();
  
                         
  
                       });
  
                       
  
                     },child: Icon(Icons.cancel,color: Colors.primaryColor))
  
                     : null,
  
                     fillColor: Colors.white70,
  
                     focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.primaryColor )),
  
                     enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.primaryColor ))
  
                     ,suffixIcon:InkWell(onTap:() {
  
              setState(() {
  
              _switchsource=true;
  
              });
  
                     },child: Icon(Icons.search_rounded,color: Colors.primaryColor,)) )
  
                 )),
  
                   //----------------------------
               DropdownSearch<ClientM>(
                 mode: Mode.MENU,

  hint: "Les Clients",
  
  searchBoxController: TextEditingController(text: ''),
  isFilteredOnline: true,
                  showClearButton: true,
                  showSearchBox: true,
  dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF01689A)),
                          ),
                        ),
                        showAsSuffixIcons: true,
                        clearButtonBuilder: (_) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.clear,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                        dropdownButtonBuilder: (_) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.arrow_drop_down,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
  onFind: (String filter) async {
      ClientM client= new ClientM(idEnt: widget.idEntreprise);

      var x= await client.GetClient(filter);
      
      
      
      
       return x;
        

      
      
      
  },
  itemAsString: (ClientM u) => u.nom,
  onChanged: (ClientM data) {
      idclient=null;
      
      print(data.id);
      idclient=data.id;

  },
),
               SingleChildScrollView(
  
                 scrollDirection: Axis.vertical,
  
                             child: SingleChildScrollView(
  
                               scrollDirection: Axis.horizontal,
  
                                                         child: DataTable( columnSpacing: Responsive.isDesktop(context)? (MediaQuery.of(context).size.width)/10:15,columns: [
  
                     DataColumn(label: Text('', ),),                                      
  
                    DataColumn(label: Text('id', ),),
  
                    
  
                    DataColumn(label: Text('Label',),),                                         
  
                   DataColumn(label: Text('Quantité Disponible ',),),
  
                   DataColumn(label: Text('Prix Unitaire',)),
  
                   DataColumn(label: Text('Qte', ),),
                  
  
                  
  
                   
  
  
  
  
  
  
  
               ],
  
               rows: [
  
               
  
               
  
                
  
               for (int i=0;i<stockUnitsList.length;i++) 
  
        
  
               DataRow(cells: [
  
                   
  
               
  
                     
  
               DataCell( SizedBox( width: 10,child:Checkbox(value: stockcheckboxvaluses[i],onChanged: (bool newvalue) {
  
       
  
                setState(() {
  print(newvalue);
                
  
                  stockcheckboxvaluses[i]=(stockcheckboxvaluses[i])?false:true;
  
                  
  
               print(stockcheckboxvaluses);
  
      stockslectedArticles.add('\"'+stockUnitsList[i].article.id+'\"');
selectedIndexes.add(i);
  print(stockslectedArticles);
  
      print(selectedIndexes);

   
  
                });
  
               
  
                  
  
               
  
               }, )) ),
  
                DataCell( SizedBox( width: double.infinity,child:Text(stockUnitsList[i].article.ref.toString(),style:Textstyle()) ),),
  
                
  
                DataCell( SizedBox( width: double.infinity,child:Text(stockUnitsList[i].article.label.toString(),style:Textstyle())) ),
  
               DataCell( SizedBox( width: double.infinity,child:Text(stockUnitsList[i].qtt.toString(),style:Textstyle()) ),),
  
               DataCell( SizedBox( width: double.infinity,child:Text(stockUnitsList[i].article.prixVente.toString(),style:Textstyle()) ),),
  
               DataCell( SizedBox( width: double.infinity,child: TextField(keyboardType: TextInputType.number,decoration: InputDecoration(hintText: 'Qtt',enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.primaryColor ))),controller: qttControllers[i],)), ),
  
               ])
  
            
  
               ])
  
            ),
  
                             ),
  
  SizedBox(
  
      height:(MediaQuery.of(context).size.height)/20 ,
  
  ),
  
  Row(mainAxisAlignment:  Responsive.isDesktop(context)? MainAxisAlignment.end:MainAxisAlignment.start,children: [
  
  
  
      Padding(
  
        padding: const EdgeInsets.only(bottom:10.0),
  
        child: ElevatedButton.icon(onPressed: (){
  
          Navigator.pop(context);
  
        },icon:Icon(Icons.arrow_back)  ,style:ElevatedButton.styleFrom(primary: Colors.primaryColor ) , label: Text('Retour'),),
  
      ),
  
        Padding(
  
          padding: const EdgeInsets.only(left:8.0,right: 8.0,bottom: 10),
  
          child: ElevatedButton.icon(onPressed: ()async{
            for(int i=0;i<selectedIndexes.length; i++){
            
              selectedQtt.add(int.parse(qttControllers[i].text));
            }
               if(idclient!=null||selectedQtt.isNotEmpty){
             DevisM commandes= DevisM(idEntreprise:widget.idEntreprise,idClient:idclient,qtt: selectedQtt,idArticles: stockslectedArticles);

                      
                      var x=await commandes.CreateDevis();
                     
                       if(x.data['CreateDevis']==1){
                         
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Facturation(idEntreprise: widget.idEntreprise,)));
                         showDialog(context: context, builder: (context)=>AlertDialog(content: Container( child: Text('Devis Edité avec succés',style: Textstyle(),),)));
                       }
                      }else{
                         showDialog(context: context, builder: (context)=>Dialog(child: Container(height:50 ,child: Text('vérifier votre donnés'),)));
                      }
                              

          },icon:Icon(Icons.add)  ,style:ElevatedButton.styleFrom(primary: Colors.primaryColor ) , label: Text('Editer'),
  
        )
  
  )],)
  
  
  
              ]) ,
              );
              })));
          
    
     
  } 
  
  


}
  
  


