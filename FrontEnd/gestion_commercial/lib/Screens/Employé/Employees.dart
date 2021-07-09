
import'package:flutter/material.dart';
import 'package:gestion_commercial/Models/Authentification/User.dart';
import 'package:gestion_commercial/Models/Client/ClientModel.dart' ;
import 'package:gestion_commercial/Responsive.dart';
import 'package:gestion_commercial/Screens/Super-Admin/NavDrawer.dart';
import 'package:gestion_commercial/Screens/Super-Admin/Style/TextStyle.dart';
import 'package:gestion_commercial/Screens/User/UserNavDrawer.dart';
class Employees extends StatefulWidget {
  var idEntreprise;
Employees({this.idEntreprise});
  @override
  _EmployeesState createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {

  

  
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

  var count ;
  var _switchsource=true;
   int i;
   var userList;
      User user ;
var client;
 Future <void> _initData() async {
user= new User(null,null,null,null,null,null,null,null);
   clientList.clear();

 
    var x =await user.getEmployees(widget.idEntreprise);
  
userList=x;   

var xi = await  client.GetClient(chercherConroller.text);

  clientList=xi;
    
   
     print(clientList.toString()+'dd');
    
  }
  @override
   Widget nav;
 void initState() {
    // TODO: implement initState
    super.initState();
    nav=UserNavDrawer(z:widget.idEntreprise);
  }
  @override
  Widget build(BuildContext context) {
  return   Scaffold(
    resizeToAvoidBottomInset:false,
      appBar: Responsive.isMobile(context)==true ? AppBar(backgroundColor: Colors.white, title:Text('Employés  ',style:TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'Barlow')),elevation: 0.0 , leading: Builder(
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
      if(snapshot.connectionState==ConnectionState.waiting){
        return Scaffold(body:Center(
          child:CircularProgressIndicator()
        ) );
      }
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
              child: Text('Les Employés',style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold, fontFamily: 'Barlow')),
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
                  hintText: 'Nom Employé',
                  
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(alignment: Alignment.topLeft,child: ElevatedButton.icon(onPressed: () async{
            
            showDialog(context: context, builder: (context)=>AlertDialog(title:Text('Invité Employé'),content: TextBox(color: Colors.primaryColor,hintText: 'Email Employé',icons:  Icons.alternate_email_outlined,controller: emailController),actions: [FlatButton(onPressed: ()async{
              var x= await user.inviteEmployee(widget.idEntreprise, emailController.text);
            if(x.data['InviteUser']){
             await  Navigator.push(context,MaterialPageRoute(builder: (context)=>new Employees(idEntreprise: widget.idEntreprise,)));}
              showDialog(context: context, builder: (context)=>
              AlertDialog(content: Text('Employé invité avec succés ',style: TextStyle(),)));
            }
              
            , child: Text('Invité',style: TextStyle(color:Colors.primaryColor),))
          ,FlatButton(onPressed: ()=>Navigator.pop(context), child: Text('Annuler',style: TextStyle(color:Colors.primaryColor),))
          
          ] ));},icon: Icon(Icons.add), label:Text ('Invité Employé'),style: ElevatedButton.styleFrom(primary: Colors.primaryColor ))),
        ),
        Expanded(child: SizedBox(
          width: double.infinity,
          child: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                                                      child: DataTable(columns: [
                 DataColumn(label: Text('Nom')),  
                 DataColumn(label: Text('Prenom')),                                       
                DataColumn(label: Text('Email'),),
                DataColumn(label: Text('Téléphone')),
               DataColumn(label: Text('')),
              

                



          ],
          rows: [
           
          
             
          for(int i=0;i<userList.data['getEmployees'].length;i++)
      
           DataRow( cells:[
             
             DataCell( SizedBox( width: double.infinity,child:Text(userList.data['getEmployees'][i]['Nom']) ),),
            DataCell( SizedBox( width: double.infinity,child:Text(userList.data['getEmployees'][i]['Prenom']) ),),
           DataCell( SizedBox( width: double.infinity,child:Text(userList.data['getEmployees'][i]['Email']) ),),
           DataCell( SizedBox( width: double.infinity,child:Text(userList.data['getEmployees'][i]['Phone'].toString()) ),),
           DataCell( SizedBox( width: double.infinity,child:Row(
             children: [
DropdownButton<dynamic>(
            hint:  Text("Role"),
            value: selectedCivility,
            onChanged: (value) {
              setState(() {
                selectedCivility = value;
              });
            },
            items:<DropdownMenuItem<dynamic>>[
                DropdownMenuItem<dynamic>(
                value: '60633b7f3d3d7e00c0c907f0 ',
                child: 
                    Text(
                      'Chef-Entreprise',
                      style:  TextStyle(color: Colors.black),
                    ),
                  
                
              ),
              
              DropdownMenuItem<dynamic>(
                value: '6065c36f9ce40301e89e1ea0 ',
                child: 
                    Text(
                      'Employée',
                      style:  TextStyle(color: Colors.black),
                    ),
                  
                
              ),
              
             
              ]
            ),
              
               
               ElevatedButton.icon(onPressed: () async{
            
            },icon: Icon(Icons.update), label:Text ('Changer Role'),style: ElevatedButton.styleFrom(primary: Colors.primaryColor )),
               ElevatedButton.icon(onPressed: () async{
            
            },icon: Icon(Icons.update), label:Text ('Supprimer Employé'),style: ElevatedButton.styleFrom(primary: Colors.primaryColor )),
               
               
             ],
           ) 
           ),
           ),
           
           ]
           
            
           

            )]),
                          ),)
))
),

]
)
);
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
            idEnt: null,
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