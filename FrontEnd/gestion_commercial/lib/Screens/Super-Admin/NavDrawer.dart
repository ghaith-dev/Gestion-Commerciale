import 'package:flutter/material.dart';
import 'package:gestion_commercial/Screens/Authentifcation/Login.dart';
import 'package:gestion_commercial/Screens/Super-Admin/ModuleManagement.dart';
import 'package:gestion_commercial/Screens/Super-Admin/PlansManagement.dart';
import 'package:gestion_commercial/Screens/Super-Admin/ProfilSettings.dart';
import'package:gestion_commercial/main.dart'as main;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import'./UserTable.dart';
import'./FirmsTable.dart';
import'./PaymentTable.dart';


class NavDrawer extends StatelessWidget {
  @override
    final primaryColor= Color(0xff339999);

  Widget build(BuildContext context) {
    
    return Drawer(
    
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
        children: <Widget> [
          DrawerHeader(
            child: circularImageWithBorder('Assets/Images/avatar.jpg',50,4,primaryColor)
          ),
          ListTile(
             
              leading: Icon(Icons.business,color:Colors.black,size: 25.0,),
              title: Text('Entreprises',
              style:TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0

              )
              ),
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FirmTable()))
              },
            ),
            ListTile(
             
              leading: Icon(Icons.attach_money_outlined,color: Colors.black,size:25.0),
              title: Text('Paiements',
              style:TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0
                 
              )
              ),
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentTable()))
              },
            ),
             ListTile(
             
              leading: Icon(Icons.featured_play_list_rounded,color: Colors.black,size:30.0),
              title: Text('Packs',
              style:TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0

              )
              ),
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PlansManagement()))
              },
            ),
            ListTile(
             
              leading: Icon(Icons.group,color: Colors.black,size:30.0),
              title: Text('Utilisateurs',
              style:TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0

              )
              ),
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserTable()))
              },
            ),
            ListTile(
             
              leading: Icon(Icons.wysiwyg_rounded,color: Colors.black,size:30.0),
              title: Text('Modules',
              style:TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0

              )
              ),
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ModuleManagement()))
              },
            ),
         ListTile(
             
              leading: Icon(Icons.settings_applications,color:Colors.black,size: 30.0),
              title: Text('Paramètres du Profil',
              style:TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0

              )
              ),
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilSettings(user:main.userid ,)))
              },
            ),
             ListTile(
             
              leading: Icon(Icons.logout,color:Colors.black,size: 25.0),
              title: Text('Déconnexion',
              style:TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0

              )
              ),
              onTap: () => {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>new Login()), (route) => false)
              },
            ),

        ],


        ),
      ),
      
    );
    
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
}}