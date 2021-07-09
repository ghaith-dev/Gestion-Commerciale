
import'package:flutter/material.dart';
import 'package:gestion_commercial/Models/Client/ClientModel.dart' ;
import 'package:gestion_commercial/Models/Comptabilit%C3%A9/Compta.dart';
import 'package:gestion_commercial/Responsive.dart';
import 'package:gestion_commercial/Screens/Super-Admin/NavDrawer.dart';
import 'package:gestion_commercial/Screens/Super-Admin/Style/TextStyle.dart';
import'package:gestion_commercial/main.dart'as iduser;
import 'package:gestion_commercial/Screens/User/UserNavDrawer.dart';
class Comptabilite extends StatefulWidget {
  var idEntreprise;
  Comptabilite({this.idEntreprise});

  @override
  _ComptabiliteState createState() => _ComptabiliteState();
}

class _ComptabiliteState extends State<Comptabilite> {
  @override
  
  Widget nav;
  List<Compta>comptaList=[];
  var _ischercher =false;
    final _formkey= new GlobalKey<FormState>();
  TextEditingController numeroController = new TextEditingController();
  TextEditingController labelController      = new TextEditingController();
  TextEditingController debitController   = new TextEditingController();
  TextEditingController creditController    = new TextEditingController();
  TextEditingController updatenumeroController    = new TextEditingController();
  TextEditingController updatelabelController  = new TextEditingController();
  TextEditingController updatedebitController = new TextEditingController();
  TextEditingController updatcreditController      = new TextEditingController();
 
  
  var selectedCivility;
    var updateselectedCivility;

  var count ;
  var _switchsource=true;
   int i;
   
      Compta compta ;

 Future <void> _initData() async {
compta= new Compta(idEntreprise: widget.idEntreprise);
   comptaList.clear();
    
  

    var x =await compta.GetComptes();
      print('jawek behy');
  comptaList=x;

    
    

var xi = await  compta.GetComptes();

  
    
   }
   
    
  
  @override
 void initState() {
    // TODO: implement initState
    super.initState();
    nav=UserNavDrawer(z:widget.idEntreprise);

  }
  @override
  Widget build(BuildContext context) {
  return   Scaffold(
    resizeToAvoidBottomInset:false,
     appBar: Responsive.isMobile(context)==true ? AppBar(backgroundColor: Colors.white, title:Text('Comptabilité  ',style:TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'Barlow')),elevation: 0.0 , leading: Builder(
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
    return FutureBuilder(future: _initData(),initialData: i=0,builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      return Container(
      color: Colors.white,
      child: Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text('Les Comptes Comptables',style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold, fontFamily: 'Barlow')),
            )),
               Spacer(flex: 1,),
            Expanded(child: Container(
              
              decoration: BoxDecoration(
                
                color: Colors.white,
               
              ),
              
              child: TextField(
                
                
                onChanged: (value){
                  setState(() {
                    _ischercher=true;
                  });
                },
                decoration: 
                InputDecoration(
                  hintText: 'Numero compte',
                  
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
                 DataColumn(label: Text('Numero')),
                 DataColumn(label: Text('Label')),  
                 DataColumn(label: Text('Débit')),                                       
                DataColumn(label: Text('Crédit'),),
                DataColumn(label: Text('Resultat')),
               
               
                



          ],
          rows: [
           
           DataRow(cells:[ 
           DataCell( SizedBox( width: double.infinity,child: TextField(decoration: InputDecoration(hintText: 'Numero',enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.primaryColor ))),controller: numeroController,keyboardType: TextInputType.number)),),
           DataCell( SizedBox( width: double.infinity,child: TextField(decoration: InputDecoration(hintText: 'Label',enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.primaryColor ))),controller: labelController)),),
            DataCell(SizedBox( width: double.infinity,child: TextField(decoration: InputDecoration(hintText: 'Débit',enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.primaryColor ))),controller: debitController,keyboardType: TextInputType.number,)) ),
             DataCell( SizedBox( width: double.infinity,child: TextField(decoration: InputDecoration(hintText: 'Crédit',enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.primaryColor ))),controller: creditController,keyboardType: TextInputType.number)),),
              DataCell( SizedBox( width: double.infinity,child: ElevatedButton.icon(onPressed: ()async{
                   Compta compta = new Compta(numero: int.parse(numeroController.text),debit:double.parse(debitController.text),credit: double.parse(creditController.text),label: labelController.text,idEntreprise: widget.idEntreprise);
                   
                    var x = await compta.CreerCompte();
                    if(x.data["CreateCompte"]==1){
                    showDialog(context: context, builder: (context)=>AlertDialog(content: Text(' Compte comptable créer avec  Succés',style: Textstyle(),),actions: [FlatButton(child: Text('ok'),onPressed: ()=>{
                           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>Comptabilite(idEntreprise: widget.idEntreprise,)))})]));
                    }
                 }, label:Text("Créer un Compte Comptable"),icon: Icon(Icons.add), style: ElevatedButton.styleFrom(primary: Colors.primaryColor ),),)),
              ]),
             
        
           for(int i=0;i<comptaList.length;i++)
           DataRow( cells:[
             
            DataCell( SizedBox( width: double.infinity,child:Text(comptaList[i].numero.toString()) ),),
            DataCell( SizedBox( width: double.infinity,child:Text(comptaList[i].label.toString()) ),),
           DataCell( SizedBox( width: double.infinity,child:Text(comptaList[i].debit.toString()) ),),
           DataCell( SizedBox( width: double.infinity,child:Text(comptaList[i].credit.toString()) ),),
           DataCell( SizedBox( width: double.infinity,child: Row(
             
             children: [
               Padding(
                 padding: const EdgeInsets.only(right:11.0),
                 child: Text(comptaList[i].resultat.toString()),
               ),
               Padding(
                 padding: const EdgeInsets.only(right:8.0),
                 child: ElevatedButton.icon(onPressed: (){
                   showDialog(context: context, builder: (context)=> _buildUpdateDialog(context,comptaList[i]));
                 }, label:Text("Passer une  écriture \n comptable"),icon: Icon(Icons.description_sharp), style: ElevatedButton.styleFrom(primary: Colors.primaryColor ),),
               ),
               Spacer(),
               ElevatedButton.icon(onPressed: (){}, label:Text("Modifier Compte"),icon: Icon(Icons.mode_sharp),style:ElevatedButton.styleFrom(primary: Colors.primaryColor ) , ),
               
               
               
             ],)),),
           
           ]),
           
           ]
           
            
           

            )),
                          ),)
))


]
)
);
    });

          
  }
  Widget _buildUpdateDialog(BuildContext context,Compta client) {

  
  return new AlertDialog(
    title: const Text('Passer une ecriture comptable'),titleTextStyle: Textstyle(),
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
              
              
              
              TextBox(hintText:'Débit',inputType: TextInputType.number,color: Colors.primaryColor,controller: updatedebitController,),
              TextBox(hintText:'Crédit',inputType:TextInputType.number,color: Colors.primaryColor,controller: updatcreditController,),
              
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
          Compta compte=new Compta(
            idEntreprise: widget.idEntreprise,
            id:client.id,
            debit: double.parse(updatedebitController.text),
            credit: double.parse(updatcreditController.text),

          );
          
          var x = await compte.EcritureComptable();
          if(x.data['EcritureComptable']){
            Navigator.pop(context);
            setState(() {
             showDialog(context: context, builder: (context)=>AlertDialog(content: Text(' votre Ecriture passer avec  Succés',style: Textstyle(),),actions: [FlatButton(onPressed: ()=>{
                           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>Comptabilite(idEntreprise: widget.idEntreprise,)))
                         }, child: Text('Ok'))],));
            });
          }
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Modifier Client',style: TextStyle(color: Colors.primaryColor))),
    ],
  );
}
Widget _buildSendEmailDialog(BuildContext context,ClientM client) {
  
   TextEditingController sujetConroller = new TextEditingController();
   TextEditingController messageConroller = new TextEditingController();
  return new AlertDialog(
    title:  Text('Envoyer un mail au '+ client.nom.toString()),titleTextStyle: Textstyle(),
    content: SingleChildScrollView(
      scrollDirection: Axis.vertical,
          child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
      Column(
            children: [
      
      
      TextBox(hintText:'Sujet',color: Colors.primaryColor,controller: sujetConroller),
      TextBox(hintText:'Messsage',inputType:TextInputType.multiline,color: Colors.primaryColor,maxline: null,controller:messageConroller),
      
            ],
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
          
          
          var x = await client.SendMail(sujetConroller.text,messageConroller.text);
          print(x);
          print(client.id);
          if(x.data['ClientSendMail']){
            
              Navigator.pop(context);
            
          }
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Envoyer',style: TextStyle(color: Colors.primaryColor))),
    ],
  );
}

}