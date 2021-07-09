import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_commercial/Models/Article/Article.dart';
import 'package:gestion_commercial/Models/Client/ClientModel.dart';
import 'package:gestion_commercial/Models/Commandes/Commande.dart';
import 'package:gestion_commercial/Models/Stock/Stock.dart';
import 'package:gestion_commercial/Screens/Super-Admin/Style/TextStyle.dart';
import 'package:gestion_commercial/Screens/User/UserNavDrawer.dart';
import 'package:dropdown_search/dropdown_search.dart';


import '../../Responsive.dart';
class Commande extends StatefulWidget {
  var idEntreprise;
  
Commande({this.idEntreprise});

  @override
  _CommandeState createState() => _CommandeState();
}

class _CommandeState extends State<Commande> {
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

                    List<bool> checkboxvaluses=[];
                    List<bool> stockcheckboxvaluses=[];
                   List<TextEditingController> qttControllers=[]; 
 List<ArticleM>articleList=[];
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
    return    Scaffold(
    resizeToAvoidBottomInset:false,
      appBar: Responsive.isMobile(context)==true ? AppBar(backgroundColor: Colors.white, title:Text('Commandes  ',style:TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'Barlow')),elevation: 0.0 , leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu_rounded,color: Colors.black,size: 40.0,),
            onPressed: () => Scaffold.of(context).openDrawer(),

          ),
        ),):null,
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
     

    return FutureBuilder(
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
                child: Text('Commande',style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold, fontFamily: 'Barlow')),
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
                    hintText: 'Id Commande',
                    
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
                         child: Text('Les Commandes',style:TextStyle(fontSize: 19,fontWeight: FontWeight.bold, fontFamily: 'Barlow')),
                       ),
                     ],
                     
                   ),
                   Row(
                    
                     children: [
                     
Padding(
  padding: const EdgeInsets.only(left:8.0),
  child:   ElevatedButton.icon( onPressed: () { 
      
Navigator.push(context, MaterialPageRoute(builder: (context)=>showEditDialog())); 

   },icon: Icon(Icons.add), label:Text ('Passer  une commande '),style: ElevatedButton.styleFrom(primary: Colors.primaryColor )),
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
                   DataColumn(label: Text('Totale Ht',),),                                         
                  DataColumn(label: Text('Totale TTC',),),
                  DataColumn(label: Text('Client',)),
                  DataColumn(label: Text('*',)),

                 
                  



            ],
            rows: [
             
             
               
            for (int i=0;i<commendaesList.length;i++) 
    
            DataRow(cells: [
                  
              
                    
             
               DataCell( SizedBox( width: double.infinity,child:Text(commendaesList[i].ref.toString(),style:Responsive.isDesktop(context)? Textstyle():TextStyle(fontFamily: 'Barlow',fontSize: 18)) ),),
               DataCell( SizedBox( width: double.infinity,child:Text(commendaesList[i].totalHt.toString(),style:Responsive.isDesktop(context)? Textstyle():TextStyle(fontFamily: 'Barlow',fontSize: 18)))) ,
              DataCell( SizedBox( width: double.infinity,child:Text(commendaesList[i].totalTTC.toString(),style:Responsive.isDesktop(context)? Textstyle():TextStyle(fontFamily: 'Barlow',fontSize: 18))) ),
              DataCell( SizedBox( width: double.infinity,child:Text(commendaesList[i].cliente.toString(),style:Responsive.isDesktop(context)? Textstyle():TextStyle(fontFamily: 'Barlow',fontSize: 18))) ),
             DataCell( SizedBox( width: double.infinity,
             child:Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween
               ,children: [
               ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.mode_sharp), label:Text ('Modifier '),style: ElevatedButton.styleFrom(primary: Colors.primaryColor )),
               Padding(
                 padding: const EdgeInsets.only(left:8.0),
                 child: ElevatedButton.icon(onPressed: ()async{
                    Commandes commande = new Commandes(idEntreprise:widget.idEntreprise,ref:commendaesList[i].ref );
                   var x= await commande.DeleteCommande();
                   if(x.data['DeleteCommende'])
                    setState(() {
                      showDialog(context: context, builder: (context)=>Dialog(child: Container(height:50 ,child: Text('Commande supprimer avec succés'),)));
                     
                    });

                 }, icon: Icon(Icons.delete_forever), label:Text ('Suprimer '),style: ElevatedButton.styleFrom(primary: Colors.redAccent )),
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
          });
  }
   StatefulWidget showEditDialog(){
    return Scaffold(
          body: SafeArea(
                      child: StatefulBuilder(
            builder: ( context, setState) {  
            return AlertDialog(
              content:SingleChildScrollView(
                              child: Column(
  
            children: [
  
            Padding(
  
            padding: const EdgeInsets.only(left:8.0),
  
            child: Text('Nouveau Commande',style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold, fontFamily: 'Barlow')),
  
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
             SizedBox(
  
                width: double.infinity,
  
                child:
  
                 Container(
  
                    width: double.infinity,
  
                  child: SingleChildScrollView(
  
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
  
                 DataCell( SizedBox( width: double.infinity,child: TextField(decoration: InputDecoration(hintText: 'Nom',enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.primaryColor ))),controller: qttControllers[i],)), ),
  
                  ])
  
          
  
                  ])
  
          ),
  
                                ),)
  
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
           Commandes commandes= Commandes(idEntreprise:widget.idEntreprise,cliente:idclient,quant: selectedQtt,articles: stockslectedArticles);

                      
                      var x=await commandes.CreateCommande();
                       if(x.data['CreateCommende']==1){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Commande(idEntreprise: widget.idEntreprise,)));
                         showDialog(context: context, builder: (context)=>AlertDialog(content: Container(child: Text('commande créer avec succés',style: Textstyle(),),)));
                         
                       }
                      }else{
                         showDialog(context: context, builder: (context)=>Dialog(child: Container(height:50 ,child: Text('vérifier votre donnés'),)));
                      }
                              

        },icon:Icon(Icons.add)  ,style:ElevatedButton.styleFrom(primary: Colors.primaryColor ) , label: Text('Créer'),
  
      )
  
  )],)
  
  
  
            ]),
              ) ,
            );
            })));
          
    
     
  } 
  
  


}
  
  
