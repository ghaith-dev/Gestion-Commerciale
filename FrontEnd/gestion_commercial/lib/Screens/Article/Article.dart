
import'package:flutter/material.dart';
import 'package:gestion_commercial/Models/Article/Article.dart' ;
import 'package:gestion_commercial/Responsive.dart';
import 'package:gestion_commercial/Screens/Super-Admin/NavDrawer.dart';
import 'package:gestion_commercial/Screens/Super-Admin/Style/TextStyle.dart';
import 'package:gestion_commercial/Screens/User/UserNavDrawer.dart';
class Article extends StatefulWidget {
  var idEntreprise;
  Article({this.idEntreprise});
  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  
  List<ArticleM>articleList=[];
  var _ischercher =false;
    final _formkey= new GlobalKey<FormState>();
  TextEditingController labelController = new TextEditingController();
  TextEditingController prixAchatController      = new TextEditingController();
  TextEditingController prixVenteController   = new TextEditingController();
  TextEditingController updatelabelController = new TextEditingController();
  TextEditingController updateprixAchatController      = new TextEditingController();
  TextEditingController updateprixVenteController   = new TextEditingController();
    TextEditingController chercherConroller  = new TextEditingController();
  var selectedCivility;
    var updateselectedCivility;

  var count ;
  var _switchsource=false;
   int i;
   
      ArticleM article ;

 Future <void> _initData() async {
   
article= new ArticleM(idEntreprise: widget.idEntreprise,label: "");

   articleList.clear();
 
 print('ab');
  var x =await article.GetArticle();
  print('x');
    if(!_switchsource){
  print('first test 2');
    var x =await article.GetArticle();
  articleList=x;
    print(x);
    }else{
article= new ArticleM(idEntreprise: widget.idEntreprise,label: chercherConroller.text);
var xi = await  article.GetArticle();
print(xi);
 print('first test3');
  articleList=xi;
    
   }
     print(articleList.toString()+'dd');
     
  }
  Widget nav;
  @override
 void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
    nav=UserNavDrawer(z:widget.idEntreprise);

  }
  @override
  Widget build(BuildContext context) {
  return   Scaffold(
    resizeToAvoidBottomInset:false,
       appBar: Responsive.isMobile(context)==true ? AppBar(backgroundColor: Colors.white, title:Text('Articles  ',style:TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'Barlow')),elevation: 0.0 , leading: Builder(
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
          Expanded(flex:1,child: Container(child: nav,)),
          Expanded(flex:5,child: Container(color: Colors.primaryColor,child: ClientTable(),))
        ],
      ) :
      ClientTable()
    ); 
    
  }
  Widget ClientTable(){
       var width=MediaQuery.of(context).size.width;

    var height=MediaQuery.of(context).size.height;
    return FutureBuilder(future:_initData() ,initialData: i=0,builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      return Container(
      color: Colors.white,
      child: Column(
      children: [
        Row(
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text('Les Articles',style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold, fontFamily: 'Barlow')),
            )),
               Spacer(flex: 1,),
            Expanded(child: Container(
              
              decoration: BoxDecoration(
                
                color: Colors.white,
               
              ),
              
              child: TextField(
                
                controller: chercherConroller,
                onChanged: (value){
                  setState(() {
                    _ischercher=true;
                  });
                },
                decoration: 
                InputDecoration(
                  hintText: 'Label d\'Article',
                  
                  prefixIcon: _ischercher ? InkWell(onTap: (){
                    setState(() {
                      _ischercher=false;
                      _switchsource=true;
                      chercherConroller.clear();
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
                  },child: Icon(Icons.search_rounded,color: Colors.primaryColor,)) ),
                  )
                  )),
               
          ],
        ),
        Expanded(child: SizedBox(
          width: double.infinity,
          child: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                                                      child: DataTable(columns: [
                 DataColumn(label: Text('ref'),),
                 DataColumn(label: Text('Label'),),                                         
                DataColumn(label: Text('PrixAchat'),),
                DataColumn(label: Text('PrixVente')),
               
                DataColumn(label: Text('*')),



          ],
          rows: [
           
           DataRow(cells:[ 
             DataCell( Text('')),
             DataCell( SizedBox( width: double.infinity,child: TextField(decoration: InputDecoration(hintText: 'Label',enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.primaryColor ))),controller: labelController,)),),
             DataCell( SizedBox( width: double.infinity,child: TextField(decoration: InputDecoration(hintText: 'PrixAchat',enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.primaryColor ))),controller: prixAchatController,)),),
           DataCell( SizedBox( width: double.infinity,child: TextField(decoration: InputDecoration(hintText: 'PrixVente',enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.primaryColor ))),controller: prixVenteController)),),
           
              DataCell( ElevatedButton.icon(onPressed: () async{
                ArticleM article = new ArticleM(idEntreprise: widget.idEntreprise,label: labelController.text,prixAchat: double.parse(prixAchatController.text),prixVente:double.parse(prixVenteController.text));
                var x = await article.CreateArticle();
                setState(() {
                if(x.data['CreateArticle']==1){
                  
                     print('good');
                     labelController.clear();
                     prixAchatController.clear();
                    prixVenteController.clear();
                     
                     
                  
                 
                }else{
                  if(x.data['CreateArticle']==0)
                showDialog(context: context, builder: (context)=>SimpleDialog(title: Text('Article existé'),children: [Column(children: [
                  Text('l\'email de article est existé,insrer une autre Article' ,style: Textstyle(), ),
                  FlatButton(onPressed: (){
                    Navigator.pop(context);

                  }, child: Text('Ok',style: TextStyle(color:Colors.primaryColor),))

                ],)],));
                else{
                  print('erreur');
                }
                }});
               },icon: Icon(Icons.add), label:Text ('Ajouter'),style: ElevatedButton.styleFrom(primary: Colors.primaryColor ),
              )),
           ]),
             
          for (ArticleM article in articleList) 
            
      
           DataRow( cells:[
             DataCell( SizedBox( width: double.infinity,child:Text(article.ref.toString())) ),
             DataCell( SizedBox( width: double.infinity,child:Text(article.label)) ),
            DataCell( SizedBox( width: double.infinity,child:Text(article.prixAchat.toString()) ),),
           DataCell( SizedBox( width: double.infinity,child:Text(article.prixVente.toString()) ),),
           
           DataCell( SizedBox( width: double.infinity,child:Row(
             children: [
               InkWell(child: Icon(Icons.mode_rounded,color:Colors.primaryColor,),onTap: (){showDialog(context: context,builder: (context) =>_buildUpdateDialog(context,article));
               print('aa');},),
               Spacer(),
               InkWell(child: Icon(Icons.delete_rounded,color:Colors.primaryColor),onTap: (){
                showDialog(context: context, builder: (context)=>AlertDialog(content: Text('Vous êtes sûr de supprimer ce article ??',style: Textstyle(),),actions: [
                FlatButton(onPressed: ()async{
                  var x= await article.CreateArticle(); 
                  setState(() {
                   Navigator.pop(context);
                  });
                  
                  
                  

                }, child: Text('Oui')),
                FlatButton(onPressed: ()async{
             
                  Navigator.pop(context);

                }, child: Text('Non')),
                ],));
               },),
               Spacer(),
               
               
               
             ],
           ) 
           ),
           ),
           
           ]
           
            
           

            )]),
                          ),)
)))]));
    });

          
  }
  Widget _buildUpdateDialog(BuildContext context,ArticleM article) {
  
    updatelabelController.text=article.label;
    updateprixAchatController.text=article.prixAchat.toString();
    updateprixVenteController.text=article.prixVente.toString();
    
  return new AlertDialog(
    title: const Text('Modifier Client'),titleTextStyle: Textstyle(),
    content: SingleChildScrollView(
      scrollDirection: Axis.vertical,
          child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
      Form(
        key:_formkey,
              child: Column(
            children: [
              
              
              TextBox(hintText:'Label',inputType:TextInputType.text,color: Colors.primaryColor,controller: updatelabelController,labeltext: 'Label'),
              TextBox(hintText:'Prix Achat',inputType:TextInputType.text,color: Colors.primaryColor,controller: updateprixAchatController,labeltext: 'Prix Achat'),
              TextBox(hintText:'Prix Vente',inputType: TextInputType.emailAddress,color: Colors.primaryColor,controller: updateprixVenteController,labeltext: 'Prix Vente'),
             
            ],
          ),
      )
          ],
        ),
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Fermer',style: TextStyle(color: Colors.primaryColor),),
        
      ),
       FlatButton(
        onPressed: () async{
          ArticleM articleu=new ArticleM(
            idEntreprise: widget.idEntreprise,
            id:article.id,
            prixAchat: double.parse(updateprixAchatController.text),
            prixVente: double.parse(updateprixVenteController.text)
          );
          
          var x = await articleu.UpdateClient();
          if(x.data['UpdateArticle']){
            setState(() {
              Navigator.pop(context);
            });
          }
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Modifier Client',style: TextStyle(color: Colors.primaryColor))),
    ],
  );
}

}