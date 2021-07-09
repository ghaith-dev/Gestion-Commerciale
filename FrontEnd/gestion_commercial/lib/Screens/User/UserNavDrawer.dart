

import 'package:flutter/material.dart';
import 'package:gestion_commercial/Models/Authentification/Entreprise.dart';
import 'package:gestion_commercial/Models/Authentification/Module.dart';
import 'package:gestion_commercial/Screens/Authentifcation/Login.dart';
import 'package:gestion_commercial/Screens/Authentifcation/Plans.dart';
import 'package:gestion_commercial/Screens/Employ%C3%A9/Employees.dart';
import 'package:gestion_commercial/Screens/User/Userdashboard.dart';
import 'package:gestion_commercial/main.dart'as main;
import 'package:gestion_commercial/Screens/Super-Admin/ProfilSettings.dart';
import 'package:gestion_commercial/Screens/Super-Admin/Style/TextStyle.dart';

import '../../Responsive.dart';
class UserNavDrawer extends StatefulWidget {
  @override
  var x;
  var z;
  UserNavDrawer({this.x,this.z});
  
  _UserNavDrawerState createState() => _UserNavDrawerState();
  
}

class _UserNavDrawerState extends State<UserNavDrawer> {
  @override
  Entreprise entr = new Entreprise(null,null,null,null,null,null,null,null);
  var count,modulename,countsub;
  var t;
  var firm;
  _initData()async{
    //print(widget.x);
var y = await entr.getfirm(widget.z);
    count=y.data['getFirm']['module'].length;
    modulename=y.data['getFirm']['module'];
    firm=y.data['getFirm'];
    countsub=y.data['getFirm']['module'].length;
t=y.data['getFirm']['NomLegal'];

  }
  void initState() {
    // TODO: implement initState
    super.initState();
    
     _initData();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
            if(snapshot.connectionState==ConnectionState.waiting){
              return Container(color: Colors.white,child: Center(child: CircularProgressIndicator(),));
            }
          return Container(
            color: Colors.white,
                      child: Drawer(
              elevation:0.0,
              child: Container(
                color:Colors.white,
                              child: ListView(
        
            children:[ 
                DrawerHeader(child: Container(
                  width: double.infinity,
                                  child: Column(
                    children: [
                      CircleAvatar(
                        
                      backgroundImage:Responsive.isMobile(context)? NetworkImage('http://192.168.1.16:3000/Images/person.jpg',headers: <String,String>{
                        'Access-Control-Allow-Headers': '*'
                      }) : NetworkImage('http://192.168.1.13:3000/Images/person.jpg',headers: <String,String>{
                        'Access-Control-Allow-Headers': '*'
                      }),
                       radius: 50,
                      ),
                      
                    Padding(
                      padding: const EdgeInsets.only(top:3.0),
                      child: Text('${firm['NomLegal']}',style: Titelstyle(),),
                    )
                              
                       
                      
                        
                      

                    ],
                  ),
                )),
            ListTile(title: Text('Dashboard',style: Textstyle()),onTap: (){
             
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>new UserDashboard(x: widget.z,)));
                
            },),
                for(int i=0;i<count;i++)
                ExpansionTile(title: Text("${modulename[i]['libelle']}",style: Textstyle(),),
                  children: [
                    for(int j=0;j<modulename[i]['SubModule'].length;j++)
                    
                    ListTile(selectedTileColor: Colors.primaryColor,title: Text("${modulename[i]['SubModule'][j]}",style: Textstyle()),onTap: (){
                      Navigator.pushNamed(context, '/${modulename[i]['SubModule'][j]}',arguments:widget.z,);

                    },)
                  ],
                ),
                main.userid.role.libelle=="Chef-Entreprise"? ListTile(title: Text('Employés',style: Textstyle()),onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>new Employees(idEntreprise:widget.z)));
                },):null,
                ListTile(title: Text('Paramètres du profil',style: Textstyle()),onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>new ProfilSettings(user: main.userid,)));
                },),
                ListTile(title: Text('Déconnexion',style: Textstyle()),onTap: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>new Login()), (route) => false);
                },),
        ]),
              ),
      ),
          );
          });
      
    
    
  }
  static Widget circularImageWithBorder(String imgPath, double rad, double borderWidth, Color borderColor) {
  return CircleAvatar(
      radius: rad + borderWidth,
      backgroundColor: borderColor,
      child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                    
                      child: Image.asset( imgPath,
                      
                       
                        
                        
                        fit: BoxFit.fill,
                        
                      )));
}
}