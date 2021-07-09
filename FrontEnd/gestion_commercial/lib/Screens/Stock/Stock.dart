import 'package:flutter/material.dart';
import 'package:gestion_commercial/Models/Article/Article.dart';
import 'package:gestion_commercial/Models/Stock/Stock.dart';
import 'package:gestion_commercial/Screens/Super-Admin/Style/TextStyle.dart';
import 'package:gestion_commercial/Screens/User/UserNavDrawer.dart';

import '../../Responsive.dart';
class Stock extends StatefulWidget {

  @override
   var idEntreprise;
  
Stock({this.idEntreprise});
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {
  @override
  List<String> slectedArticles=[];
    List<String> stockslectedArticles=[];
  var _ischercher=false;
                    var  _switchsource=true;
                     ArticleM article ;
                     StockM stockUnit;
                    List<bool> checkboxvaluses=[];
                    List<bool> stockcheckboxvaluses=[];
                    
 List<ArticleM>articleList=[];
  List<StockM>stockUnitsList=[];
 fillCheckboxValues(int count){
   List<bool> cbvalues=[];
 
 for (int i=0;i<count;i++){
cbvalues.add(false);
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

   articleList.clear();
   stockUnitsList.clear();

  stockUnit=new StockM(idEntreprise: widget.idEntreprise);
 
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
_getcountStock().then((value) => 
stockcheckboxvaluses.addAll( fillCheckboxValues(value))
);
  


    nav=UserNavDrawer(z:widget.idEntreprise);


  
      

 print(articleList.toString()+'dd');
  }
  @override
  Widget build(BuildContext context) {
    return    Scaffold(
    resizeToAvoidBottomInset:false,
       appBar: Responsive.isMobile(context)==true ? AppBar(backgroundColor: Colors.white, title:Text('Client  ',style:TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'Barlow')),elevation: 0.0 , leading: Builder(
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
  Widget StockPage(){
    return   Column(
                  
                  children: [
               Expanded(flex:2,child: Container(color: Colors.white,child:Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Row(
                     children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text('Stock',style:TextStyle(fontSize: 19,fontWeight: FontWeight.bold, fontFamily: 'Barlow')),
                       ),
                     ],
                     
                   ),
                   Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                 
                ),
                
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
decoration: 
                    InputDecoration(
                      hintText: 'ID Article',
                      
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
                  ),
                )),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                     

Padding(
  padding: const EdgeInsets.only(right:8.0),
  child:   Padding(
    padding: const EdgeInsets.only(left:8.0),
    child: ElevatedButton.icon(onPressed: () {  },icon: Icon(Icons.mode_rounded), label:Text ('Modifier quentité'),style: ElevatedButton.styleFrom(primary: Colors.primaryColor )),
  ),
),
ElevatedButton.icon(onPressed: ()async {  
  StockM stock= new StockM(idEntreprise: widget.idEntreprise,id:stockslectedArticles[0] );
  var x=await stock.DeleteArticleFromStock();
  if(x.data['DeleteStockUnit']){
     
    setState(() {
   
      showDialog(context: context, builder: (context)=>Container(width: 70,height:50 ,child: Dialog(child: Container(width: 70,height:100,child: Center(child: Text('l\'Article est bien retiré',style: Textstyle(),))),)));
    });
     
  } ;
},icon: Icon(Icons.delete), label:Text ('Retirer \n de Stock'),style: ElevatedButton.styleFrom(primary: Colors.primaryColor ))

               ],),
               

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
                                                        child: DataTable(columnSpacing: 15,columns: [
                    DataColumn(label: Text('', ),),                                      
                   DataColumn(label: Text('id', ),),
                   DataColumn(label: Text('Label',),),                                         
                  DataColumn(label: Text('Qte',),),
                  DataColumn(label: Text('PrixVente',)),
                 
                  



            ],
            rows: [
             
             
               
            for (int i=0;i<stockUnitsList.length;i++) 
    
            DataRow(cells: [
                  
              
                    
             DataCell( SizedBox( width: double.infinity,child:Checkbox(value: stockcheckboxvaluses[i],onChanged: (bool newvalue) {
   
               setState(() {
               print(stockcheckboxvaluses);
                 stockcheckboxvaluses[i]=(stockcheckboxvaluses[i])?false:true;
                 
                 
  stockslectedArticles.add(stockUnitsList[i].id);
 print(slectedArticles);
               });
              
                 
              
               }, )) ),
               DataCell( SizedBox( width: double.infinity,child:Text(stockUnitsList[i].article.ref.toString(),style:TextStyle(fontSize: 14,fontFamily:'Barlow')) ),),
               DataCell( SizedBox( width: double.infinity,child:Text(stockUnitsList[i].article.label.toString(),style:TextStyle(fontSize: 14,fontFamily:'Barlow'))) ),
              DataCell( SizedBox( width: double.infinity,child:Text(stockUnitsList[i].qtt.toString(),style:TextStyle(fontSize: 14,fontFamily:'Barlow')) ),),
             DataCell( SizedBox( width: double.infinity,child:Text(stockUnitsList[i].article.prixVente.toString(),style:TextStyle(fontSize: 14,fontFamily:'Barlow')) ),),
              ])
        
              ])
        ),
                            ),)
),
               
               
               
               )
               ),
               

                ],);
             
  }
  Widget Articlepage(){
return Column(
  children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(alignment: Alignment.topLeft,child: Text('Stock',style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold, fontFamily: 'Barlow'))),
        ),
  
        
Container(
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                 
                ),
                
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
decoration: 
                    InputDecoration(
                      hintText: 'ID Article',
                      
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
                  ),
                )),
                
    Container(color: Colors.white,child:Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
          alignment: Alignment.topLeft,
                  child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Les Articles',style:TextStyle(fontSize: 19,fontWeight: FontWeight.bold, fontFamily: 'Barlow')),
          ),
        )])),
        Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      
Container(
  child:   Padding(
  
    padding: const EdgeInsets.only(left:8.0),
  
    child:   ElevatedButton.icon( onPressed: () { 
  
       showDialog(context: context, builder: (context)=>AlertDialog(
  
         title: Text('alimenter stock',style: Textstyle(),),
  
         actions: [FlatButton(onPressed: ()=>Navigator.pop(context)
  
         , child: Text('Annuler',style: TextStyle(color: Colors.primaryColor),)),
  
         FlatButton(onPressed: () async{
  
           try{
  
             StockM addstock = new StockM(idEntreprise: widget.idEntreprise,qtt: int.parse(qttController.text),idArticle:slectedArticles[0] );
  
             print(addstock.idEntreprise);
  
             var result = await addstock.AddArticleToStock();
  
             print(result);
  
             if(result.data['AddArticle']==1){
  await stockcheckboxvaluses.add(true);
               await Navigator.pop(context);
  
               setState(() {
  
                  checkboxvaluses.clear();
  
                checkboxvaluses.addAll(fillCheckboxValues(articleList.length)) ;
  
                print(checkboxvaluses);
  
               });
  
               
  
               qttController.clear();
  await Navigator.push(context, MaterialPageRoute(builder: (context)=>new Stock(idEntreprise: widget.idEntreprise,)));
    showDialog(context: context, builder: (context)=>Container(width: 70,height:50 ,child: Dialog(child: Container(width: 70,height:100,child: Center(child: Text('l\'article est  ajouté avec Succés',style: Textstyle(),))),)));

               
  
               
  
             }else{
  
               if(result.data['AddArticle']==0)
  
                   await stockcheckboxvaluses.add(true);
  
               await Navigator.pop(context);
  
               setState(() {
  
                  checkboxvaluses.clear();
  
                checkboxvaluses.addAll(fillCheckboxValues(articleList.length)) ;
  
                stockcheckboxvaluses.clear();
  
                stockcheckboxvaluses.addAll(fillCheckboxValues(stockUnitsList.length)) ;
  
                print(stockcheckboxvaluses);
  
                slectedArticles.clear();
  
                print(stockcheckboxvaluses.toString()+"hola");
  
               });
  
               qttController.clear();
  
               showDialog(context: context, builder: (context)=>Container(width: 70,height:50 ,child: Dialog(child: Container(width: 70,height:100,child: Center(child: Text('l\'Article  deja Exister Dans le stock',style: Textstyle(),))),)));
  
             }
  
           }catch(e){
  
             print(e);
  
           }
  
         }
  
         , child: Text('Ajouter',style: TextStyle(color: Colors.primaryColor),))
  
         ],
  
         content: Form(child: TextBox(color: Colors.primaryColor,hintText: 'Quentité',controller: qttController)),
  
       ));
  
  
  
  
  
  
  
  
  
  
  
     },icon: Icon(Icons.add), label:Text ('Ajouter a Stock'),style: ElevatedButton.styleFrom(primary: Colors.primaryColor )),
  
  ),
),


                ]) ,
                
                Container(color: Colors.white,
                child: SizedBox(
            width: double.infinity,
            child: Container(
              child: SingleChildScrollView(
                 scrollDirection: Axis.vertical,
                 child: SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                                             child: DataTable(columnSpacing: 15,columns: [
                     DataColumn(label: Text('*', ),),                                      
                    DataColumn(label: Text('id', ),),
                    DataColumn(label: Text('Label',),),                                         
                   DataColumn(label: Text('PrixAchat',),),
                   DataColumn(label: Text('PrixVente',)),
                  
                   



            ],
            rows: [
             
             
              for (int i=0;i<articleList.length;i++) 
    
            DataRow(cells: [
                   
              
                     
             DataCell( SizedBox( width: 20,child:Checkbox(value: checkboxvaluses[i],onChanged: (bool newvalue) {
   
                setState(() {
                print(checkboxvaluses);
                  checkboxvaluses[i]=(checkboxvaluses[i])?false:true;
                  
                  if(newvalue){
  slectedArticles.add(articleList[i].id);}else{
    slectedArticles.clear();
  }
 print(slectedArticles);
                });
              
                  
              
                }, )) ),
                DataCell( SizedBox( width: double.infinity,child:Text(articleList[i].ref.toString(),style:TextStyle(fontSize: 14,fontFamily:'Barlow')) ),),
                DataCell( SizedBox( width: double.infinity,child:Text(articleList[i].label.toString(),style:TextStyle(fontSize: 14,fontFamily:'Barlow'))) ),
              DataCell( SizedBox( width: double.infinity,child:Text(articleList[i].prixAchat.toString(),style:TextStyle(fontSize: 14,fontFamily:'Barlow')) ),),
             DataCell( SizedBox( width: double.infinity,child:Text(articleList[i].prixVente.toString(),style:TextStyle(fontSize: 14,fontFamily:'Barlow')) ),),
              ])
        
             ]),
                 ),)
),
                
                
                
                ))]);
                 
           
        
        
        
        
    
                    
  }
  Widget StockTableMobile(){
    return FutureBuilder(
        future:_initData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
             
        return   PageView(
          children: [
Articlepage(),
StockPage()
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
                child: Text('Stock',style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold, fontFamily: 'Barlow')),
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
                )))
            ],)
                      )
               ),
               
            Expanded(
              flex: 4,
                        child: Row(children: [
                Expanded(child: Column(
                  
                  children: [
               Expanded(flex:2,child: Container(color: Colors.white,child:Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Row(
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(left:8.0),
                         child: Text('Les Articles',style:TextStyle(fontSize: 19,fontWeight: FontWeight.bold, fontFamily: 'Barlow')),
                       ),
                     ],
                     
                   ),
                   Row(
                    
                     children: [
                     
Padding(
  padding: const EdgeInsets.only(left:8.0),
  child:   ElevatedButton.icon( onPressed: () { 
     showDialog(context: context, builder: (context)=>AlertDialog(
       title: Text('alimenter stock',style: Textstyle(),),
       actions: [FlatButton(onPressed: ()=>Navigator.pop(context)
       , child: Text('Annuler',style: TextStyle(color: Colors.primaryColor),)),
       FlatButton(onPressed: () async{
         try{
           StockM addstock = new StockM(idEntreprise: widget.idEntreprise,qtt: int.parse(qttController.text),idArticle:slectedArticles[0] );
           print(addstock.idEntreprise);
           var result = await addstock.AddArticleToStock();
           print(result);
           if(result.data['AddArticle']==1){
             await stockcheckboxvaluses.add(true);
             await Navigator.pop(context);
             setState(() {
               checkboxvaluses.clear();
              checkboxvaluses.addAll(fillCheckboxValues(articleList.length)) ;
              print(checkboxvaluses);
             });
             
             qttController.clear();
             showDialog(context: context, builder: (context)=>Container(width: 70,height:50 ,child: Dialog(child: Container(width: 70,height:100,child: Center(child: Text('la stock  est alimenter avec Succés',style: Textstyle(),))),)));
             
           }else{
             if(result.data['AddArticle']==0)
                await stockcheckboxvaluses.add(true);
             await Navigator.pop(context);
             setState(() {
               checkboxvaluses.clear();
              checkboxvaluses.addAll(fillCheckboxValues(articleList.length)) ;
              stockcheckboxvaluses.clear();
              stockcheckboxvaluses.addAll(fillCheckboxValues(stockUnitsList.length)) ;
              print(stockcheckboxvaluses);
              slectedArticles.clear();
              print(stockcheckboxvaluses.toString()+"hola");
             });
             qttController.clear();
             showDialog(context: context, builder: (context)=>Container(width: 70,height:50 ,child: Dialog(child: Container(width: 70,height:100,child: Center(child: Text('l\'Article  deja Exister Dans le stock',style: Textstyle(),))),)));
           }
         }catch(e){
           print(e);
         }
       }
       , child: Text('Ajouter',style: TextStyle(color: Colors.primaryColor),))
       ],
       content: Form(child: TextBox(color: Colors.primaryColor,hintText: 'Quentité',controller: qttController)),
     ));





   },icon: Icon(Icons.add), label:Text ('Ajouter a Stock'),style: ElevatedButton.styleFrom(primary: Colors.primaryColor )),
),


               ],)

                 ],
               ))),
               Expanded(flex:10,child: Container(color: Colors.white,
               child: SizedBox(
            width: double.infinity,
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                                                        child: DataTable(columns: [
                    DataColumn(label: Text('', ),),                                      
                   DataColumn(label: Text('id', ),),
                   DataColumn(label: Text('Label',),),                                         
                  DataColumn(label: Text('PrixAchat',),),
                  DataColumn(label: Text('PrixVente',)),
                 
                  



            ],
            rows: [
             
             
              for (int i=0;i<articleList.length;i++) 
    
            DataRow(cells: [
                  
              
                    
             DataCell( SizedBox( width: double.infinity,child:Checkbox(value: checkboxvaluses[i],onChanged: (bool newvalue) {
   
               setState(() {
               print(checkboxvaluses);
                 checkboxvaluses[i]=(checkboxvaluses[i])?false:true;
                 
                 if(newvalue){
  slectedArticles.add(articleList[i].id);}else{
    slectedArticles.clear();
  }
 print(slectedArticles);
               });
              
                 
              
               }, )) ),
               DataCell( SizedBox( width: double.infinity,child:Text(articleList[i].ref.toString(),style:Textstyle()) ),),
               DataCell( SizedBox( width: double.infinity,child:Text(articleList[i].label.toString(),style:Textstyle())) ),
              DataCell( SizedBox( width: double.infinity,child:Text(articleList[i].prixAchat.toString(),style:Textstyle()) ),),
             DataCell( SizedBox( width: double.infinity,child:Text(articleList[i].prixVente.toString(),style:Textstyle()) ),),
              ])
        
             ]),
                            ),)
),
               
               
               
               )),
               

                )],)
                
                
                
                
                ),
                
                Expanded(child: Column(
                  
                  children: [
               Expanded(flex:2,child: Container(color: Colors.white,child:Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Row(
                     children: [
                       Text('Stock',style:TextStyle(fontSize: 19,fontWeight: FontWeight.bold, fontFamily: 'Barlow')),
                     ],
                     
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                     

Padding(
  padding: const EdgeInsets.only(right:8.0),
  child:   Padding(
    padding: const EdgeInsets.only(left:8.0),
    child: ElevatedButton.icon(onPressed: () {  },icon: Icon(Icons.mode_rounded), label:Text ('Modifier quentité'),style: ElevatedButton.styleFrom(primary: Colors.primaryColor )),
  ),
),
ElevatedButton.icon(onPressed: ()async {  
  StockM stock= new StockM(idEntreprise: widget.idEntreprise,id:stockslectedArticles[0] );
  var x=await stock.DeleteArticleFromStock();
  if(x.data['DeleteStockUnit']){
     
    setState(() {
   
      showDialog(context: context, builder: (context)=>Container(width: 70,height:50 ,child: Dialog(child: Container(width: 70,height:100,child: Center(child: Text('l\'Article  deja Exister Dans le stock',style: Textstyle(),))),)));
    });
     
  } ;
},icon: Icon(Icons.delete), label:Text ('Retirer de Stock'),style: ElevatedButton.styleFrom(primary: Colors.primaryColor  ))

               ],)

                 ],
               ))),
               Expanded(flex:10,child: Container(color: Colors.white,
               child: SizedBox(
            width: double.infinity,
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                                                        child: DataTable(columns: [
                    DataColumn(label: Text('', ),),                                      
                   DataColumn(label: Text('id', ),),
                   DataColumn(label: Text('Label',),),                                         
                  DataColumn(label: Text('Qte',),),
                  DataColumn(label: Text('PrixVente',)),
                 
                  



            ],
            rows: [
             
             
               
            for (int i=0;i<stockUnitsList.length;i++) 
    
            DataRow(cells: [
                  
              
                    
             DataCell( SizedBox( width: double.infinity,child:Checkbox(value: stockcheckboxvaluses[i],onChanged: (bool newvalue) {
   
               setState(() {
               print(stockcheckboxvaluses);
                 stockcheckboxvaluses[i]=(stockcheckboxvaluses[i])?false:true;
                 
                 
  stockslectedArticles.add(stockUnitsList[i].id);
 print(slectedArticles);
               });
              
                 
              
               }, )) ),
               DataCell( SizedBox( width: double.infinity,child:Text(stockUnitsList[i].article.ref.toString(),style:Textstyle()) ),),
               DataCell( SizedBox( width: double.infinity,child:Text(stockUnitsList[i].article.label.toString(),style:Textstyle())) ),
              DataCell( SizedBox( width: double.infinity,child:Text(stockUnitsList[i].qtt.toString(),style:Textstyle()) ),),
             DataCell( SizedBox( width: double.infinity,child:Text(stockUnitsList[i].article.prixVente.toString(),style:Textstyle()) ),),
              ])
        
              ])
        ),
                            ),)
),
               
               
               
               )),
               

                ],)
                
                
                
                
                ),
              ],),
            ),
          ],
        )
      );
          });
  }
  }
  
