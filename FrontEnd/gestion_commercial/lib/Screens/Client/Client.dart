
import'package:flutter/material.dart';
import 'package:gestion_commercial/Models/Client/ClientModel.dart' ;
import 'package:gestion_commercial/Responsive.dart';
import 'package:gestion_commercial/Screens/Super-Admin/NavDrawer.dart';
import 'package:gestion_commercial/Screens/Super-Admin/Style/TextStyle.dart';
import 'package:gestion_commercial/Screens/User/UserNavDrawer.dart';
class Client extends StatefulWidget {
  var ident;
  var obj;
  Client({this.ident,this.obj});
  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  List<ClientM>clientList=[];
  var _ischercher =false;
    final _formkey= new GlobalKey<FormState>();
  TextEditingController civiliteController = new TextEditingController();
  TextEditingController nomController      = new TextEditingController();
  TextEditingController prenomController   = new TextEditingController();
  TextEditingController emailController    = new TextEditingController();
  TextEditingController phoneController    = new TextEditingController();
  TextEditingController commentController  = new TextEditingController();
  TextEditingController updateciviliteController = new TextEditingController();
  TextEditingController updatenomController      = new TextEditingController();
  TextEditingController updateprenomController   = new TextEditingController();
  TextEditingController updateemailController    = new TextEditingController();
  TextEditingController updatephoneController    = new TextEditingController();
  TextEditingController updatecommentController  = new TextEditingController();
   TextEditingController chercherConroller  = new TextEditingController();
  var selectedCivility;
    var updateselectedCivility;
Widget nav;
  var count ;
  var _switchsource=true;
   int i;
   
      ClientM client ;

 Future <void> _initData() async {
   print(widget.obj);
client= new ClientM(idEnt: widget.ident);
   clientList.clear();
    if(!_switchsource){
 
    var x =await client.GetClients();
  
    print(x);
    }else{

var xi = await  client.GetClient(chercherConroller.text);

  clientList=xi;
    
   }
     print(clientList.toString()+'dd');
    
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.ident);
    nav=UserNavDrawer(z: widget.ident,x:widget.ident);
  }
  @override
 
  @override
  Widget build(BuildContext context) {
  return   Scaffold(
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
          Expanded(flex:1,child:  Container(child: nav,)),
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
            Expanded(child: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text('Les Clients',style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold, fontFamily: 'Barlow')),
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
                  hintText: 'Nom de Client',
                  
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
                 DataColumn(label: Text('Civilité'),),                                         
                DataColumn(label: Text('Nom'),),
                DataColumn(label: Text('Prenom')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Téléphone')),
                DataColumn(label: Text('Commenter')),
                DataColumn(label: Text('*')),



          ],
          rows: [
           
           DataRow(cells:[ 
             DataCell( SizedBox( width: double.infinity,child: 
             DropdownButton<dynamic>(
            hint:  Text("Civilité"),
            value: selectedCivility,
            onChanged: (value) {
              setState(() {
                selectedCivility = value;
              });
            },
            items:<DropdownMenuItem<dynamic>>[
                DropdownMenuItem<dynamic>(
                value: 'Mr',
                child: 
                    Text(
                      'Mr',
                      style:  TextStyle(color: Colors.black),
                    ),
                  
                
              ),
              
              
              
              DropdownMenuItem<dynamic>(
                value: 'Mde',
                child: 
                    Text(
                      'Mde',
                      style:  TextStyle(color: Colors.black),
                    ),
                  
                
              )
              ]
            ),
          ),
             
             
             
             
             
             ),
             DataCell( SizedBox( width: double.infinity,child: TextField(decoration: InputDecoration(hintText: 'Nom',enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.primaryColor ))),controller: nomController,)),),
           DataCell( SizedBox( width: double.infinity,child: TextField(decoration: InputDecoration(hintText: 'Prenom',enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.primaryColor ))),controller: prenomController)),),
            DataCell(SizedBox( width: double.infinity,child: TextField(decoration: InputDecoration(hintText: 'Email',enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.primaryColor ))),controller: emailController)) ),
             DataCell( SizedBox( width: double.infinity,child: TextField(decoration: InputDecoration(hintText: 'Télephone',enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.primaryColor ))),controller: phoneController)),),
              DataCell( SizedBox( width: double.infinity,child: TextField(decoration: InputDecoration(hintText: 'Comenter',enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.primaryColor )),),controller: commentController,)),),
              DataCell( ElevatedButton.icon(onPressed: () async{
                ClientM client = new ClientM(idEnt: widget.ident,nom: nomController.text,prenom: prenomController.text,email: emailController.text,phone: int.parse(phoneController.text),comment: commentController.text,civility: selectedCivility);
                var x = await client.CreateClient();
                setState(() {
                if(x.data['CreateClient']==1){
                  
                     print('good');
                     nomController.clear();
                     prenomController.clear();
                    emailController.clear();
                     phoneController.clear();
                     commentController.clear();
                     selectedCivility=null;
                  
                 
                }else{
                  if(x.data['CreateClient']==0)
                showDialog(context: context, builder: (context)=>SimpleDialog(title: Text('Email existé'),children: [Column(children: [
                  Text('l\'email de client est existé,insrer une autre email' ,style: Textstyle(), ),
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
             
          for (ClientM client in clientList) 
            
      
           DataRow( cells:[
             
             DataCell( SizedBox( width: double.infinity,child:Text(client.civility)) ),
            DataCell( SizedBox( width: double.infinity,child:Text(client.nom) ),),
           DataCell( SizedBox( width: double.infinity,child:Text(client.prenom) ),),
            DataCell( SizedBox( width: double.infinity,child:Text(client.email) ),),
           DataCell( SizedBox( width: double.infinity,child:Text(client.phone.toString()) ),),
           DataCell( SizedBox( width: double.infinity,child:Text(client.comment) ),),
           DataCell( SizedBox( width: double.infinity,child:Row(
             children: [
               InkWell(child: Icon(Icons.mode_rounded,color:Colors.primaryColor,),onTap: (){showDialog(context: context,builder: (context) =>_buildUpdateDialog(context,client));
               print('aa');},),
               Spacer(),
               InkWell(child: Icon(Icons.delete_rounded,color:Colors.primaryColor),onTap: (){
                showDialog(context: context, builder: (context)=>AlertDialog(content: Text('Vous êtes sûr de supprimer ce client ??',style: Textstyle(),),actions: [
                FlatButton(onPressed: ()async{
                  var x= await client.DeleteClient(); 
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
               InkWell(child: Icon(Icons.send_rounded,color:Colors.primaryColor),onTap: (){

                 showDialog(context: context, builder: (context)=>_buildSendEmailDialog(context, client));
               })
               
               
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
  Widget _buildUpdateDialog(BuildContext context,ClientM client) {
    updateselectedCivility=client.civility;
    updatenomController.text=client.nom;
    updateprenomController.text=client.prenom;
    updateemailController.text=client.email;
    updatephoneController.text=client.phone.toString();
    updatecommentController.text=client.comment;
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
              DropdownButton<dynamic>(
                isExpanded: true,
              icon: Icon(Icons.arrow_drop_down),
              hint:  Text("Civilité"),
              value: updateselectedCivility,
              onChanged: (value) {
                setState(() {
                  updateselectedCivility = value;
                });
              },
              items:<DropdownMenuItem<dynamic>>[
                  DropdownMenuItem<dynamic>(
                  value: 'Mr',
                  child: 
                      Text(
                        'Mr',
                        style:  TextStyle(color: Colors.black),
                      ),
                    
                  
                ),
                
                
                
                DropdownMenuItem<dynamic>(
                  value: 'Mde',
                  child: 
                      Text(
                        'Mde',
                        style:  TextStyle(color: Colors.black),
                      ),
                    
                  
                )
                ]
              ),
              
              TextBox(hintText:'Nom',inputType:TextInputType.text,color: Colors.primaryColor,controller: updatenomController,labeltext: 'Nom'),
              TextBox(hintText:'Prenom',inputType:TextInputType.text,color: Colors.primaryColor,controller: updateprenomController,labeltext: 'Prenom'),
              TextBox(hintText:'Email',inputType: TextInputType.emailAddress,color: Colors.primaryColor,controller: updateemailController,labeltext: 'Email'),
              TextBox(hintText:'Téléphone',inputType:TextInputType.number,color: Colors.primaryColor,controller: updatephoneController,labeltext: 'Téléphone'),
              TextBox(hintText:'Commenter',inputType:TextInputType.text,color: Colors.primaryColor,controller: updatecommentController,labeltext: 'Commenter'),
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
          ClientM clientu=new ClientM(
            idEnt: widget.ident,
            id:client.id,
            nom:updatenomController.text,
prenom:updateprenomController.text,
email:updateemailController.text,
phone:int.parse(updatephoneController.text),
comment: updatecommentController.text,
civility: updateselectedCivility
          );
          
          var x = await clientu.UpdateClient();
          if(x.data['UpdateClient']){
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
void updateClientobj(ClientM client){
  
  client.nom           =updatenomController.text;
          client.prenom=updateprenomController.text;
          client.email =updateemailController.text;
          client.phone =int.parse(updatephoneController.text);
       client.civility =updateselectedCivility;
}
}