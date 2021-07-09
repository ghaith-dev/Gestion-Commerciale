import 'package:flutter/material.dart';
import 'package:gestion_commercial/Models/Authentification/Module.dart';
import 'package:gestion_commercial/Models/Client/ClientModel.dart';
import 'package:gestion_commercial/Models/Commandes/Commande.dart';
import 'package:gestion_commercial/Screens/Article/Article.dart';
import'package:gestion_commercial/Screens/Authentifcation/Login.dart';
import 'package:gestion_commercial/Screens/Authentifcation/PasswordRecovery.dart';
import'package:gestion_commercial/Screens/Authentifcation/Signup.dart';
import'package:gestion_commercial/Screens/Authentifcation/ChangePassword.dart';
import 'package:gestion_commercial/Screens/Client/Client.dart';
import 'package:gestion_commercial/Screens/Comptabilit%C3%A9/Comptabilit%C3%A9.dart';
import 'package:gestion_commercial/Screens/Facturation/Facturation.dart';
import 'package:gestion_commercial/Screens/Fournisseur/Fournisseur.dart';

import'package:gestion_commercial/Screens/Payment/PaymentScreen.dart';
import'package:gestion_commercial/Screens/Authentifcation/Plans.dart';
import'package:gestion_commercial/Screens/Authentifcation/WelcomeScreen.dart';
import 'package:gestion_commercial/Screens/Super-Admin/PlansManagement.dart';
import 'package:gestion_commercial/Screens/Super-Admin/ProfilSettings.dart';
import'package:gestion_commercial/Screens/Super-Admin/UserTable.dart';

import'package:gestion_commercial/Screens/Super-Admin/ModuleManagement.dart';

import'package:gestion_commercial/Screens/Super-Admin/DashboardSuperAdmin.dart';

import'package:gestion_commercial/Screens/Authentifcation/SignupUser.dart';
import 'package:gestion_commercial/Services/ApiConnection.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import'package:gestion_commercial/Screens/Authentifcation/Modules.dart';
import'package:gestion_commercial/Screens/Authentifcation/VerificationScreen.dart';

import 'Models/Authentification/User.dart';
import 'Screens/Commande/Commande.dart';
import 'Screens/Employé/Employees.dart';
import 'Screens/Stock/Stock.dart';
import 'Screens/User/UserDashboard.dart';
import'Services/ApiConnection.dart';
import 'package:sizer/sizer.dart';

ApiConnection apiConnection =  ApiConnection();
User userid;
void main() => runApp(
 GraphQLProvider(
        client: apiConnection.client,
        child: CacheProvider(child: MyApp()),
      ),
    );


 

class MyApp extends StatelessWidget {
  var userid;
  void setuserid(var userid){
    this.userid=userid;
 }
getuserID(){
  return this.userid;
}
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
return LayoutBuilder(                           //return LayoutBuilder
      builder: (context, constraints) {
        return OrientationBuilder(                  //return OrientationBuilder
          builder: (context, orientation) {
            //initialize SizerUtil()
            SizerUtil().init(constraints, orientation);  //initialize SizerUtil
   

 

    return MaterialApp(
      
      title: 'Gestion Commercial',
            debugShowCheckedModeBanner: false,
          
            home:new UserSignup(),

            routes:{
              '/Stock':(context)=>   Stock(idEntreprise: ModalRoute.of(context).settings.arguments),
              '/Fournisseur':(context)=>   Fournisseur(ident: ModalRoute.of(context).settings.arguments),
              '/Client':(context)=>   Client(ident: ModalRoute.of(context).settings.arguments,obj:ModalRoute.of(context).settings.arguments ,),
              '/Article':(context)=>   Article(idEntreprise: ModalRoute.of(context).settings.arguments),
              '/Commande':(context)=>   Commande(idEntreprise: ModalRoute.of(context).settings.arguments),
              '/Facturation':(context)=>   Facturation(idEntreprise: ModalRoute.of(context).settings.arguments),
              '/Comptabilié':(context)=>   Comptabilite(idEntreprise: ModalRoute.of(context).settings.arguments),

              '/Welcome':(context)=>   Welcome(),
            '/Plans':(context)=>  new Plans(null),
            '/Signup':(context)=>  new UserSignup(),
            '/CreateEnt':(context)=>  new SignUp(null,null),
            '/EmailVerification':(context)=>  new VerificationScreen(null)
            }
            ,
            

        
      );
    });
    });
  }
  }