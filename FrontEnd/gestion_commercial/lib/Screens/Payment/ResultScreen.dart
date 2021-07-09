import 'package:flutter/material.dart';
import'package:gestion_commercial/Models/Authentification/Plan.dart';
import'package:gestion_commercial/Models/Authentification/User.dart';

import 'package:gestion_commercial/Screens/Authentifcation/Modules.dart';
import 'package:gestion_commercial/Screens/Authentifcation/Plans.dart';
import 'package:gestion_commercial/Screens/Authentifcation/WelcomeScreen.dart';
import'package:sizer/sizer.dart';
import 'package:gestion_commercial/Models/Abonnement/Abonnement.dart';

// ignore: must_be_immutable
class ResultScreen extends StatefulWidget {
  
Plan plan;
String token;
User user;




  ResultScreen(Plan plan,String token,User user){
    this.plan=plan;
    this.token=token;
    this.user=user;
  }
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
    final primaryColor= Color(0xff339999);
Abonnement abonn;
  @override
  Widget build(BuildContext context) {
     return FutureBuilder(future: widget.plan.checkPayment(widget.token),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
           
         if(snapshot.connectionState==ConnectionState.waiting){
        return Scaffold(body:Center(
          child:CircularProgressIndicator()
        ) );}
            if(snapshot.data){
               
               
              return Scaffold(
                
              backgroundColor: primaryColor,
      body: SafeArea(
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          
          children: [
          Container(
            margin: EdgeInsets.only(top:5.0.h),
                   width: MediaQuery.of(context).size.width*0.9,
                    height:MediaQuery.of(context).size.height*0.9,
                      child: Card(elevation: 5.0,child:Column(children: [
        
              Text('Félicitation Votre Paiement Est Réussi.  ',style: TextStyle(color:primaryColor,fontFamily: 'Barlow' ,fontSize: 40.0 ),),
              Container(
                padding: EdgeInsets.only(top:25.0),
                width: 65.0.w,
              child: Icon(Icons.check,color: primaryColor,size: 30.0.w,)),
              Padding(
                padding: const EdgeInsets.only(top:32),
                child: ButtonTheme(
                          disabledColor: Colors.black12,
                        
 
                 height: 55.0,
                 
                 minWidth: 70.0.w,child:  FlatButton(
                   
                    disabledColor: Colors.black12,
  disabledTextColor: Colors.blueGrey,
                   shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50.0) ),
                   
                 color: primaryColor,
                 onPressed: () async {
                   abonn = new Abonnement(entreprise: widget.user,idSub: null,plan: widget.plan);
                    var x = await abonn.createSubscription();
                    print(widget.user.ident);
                    print(x);
                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Welcome()), (route) => false);
                   },
                 child:Text('Continuer',
           style: TextStyle(
                 color: Colors.white,
                 fontSize: 20.0,
                 fontWeight: FontWeight.bold

                 ),))),
              )
            
            
            ],) ,),
            
            )
          



        ],),),),
    );
            }
            return Scaffold(
              backgroundColor: Colors.redAccent[700],
      body: SafeArea(
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          
          children: [
          Container(
            margin: EdgeInsets.only(top:20.0.h),
                   width: 90.0.w,
                    height: 50.0.h,
                      child: Card(elevation: 5.0,child:Column(children: [
        
              Text('Votre Paiement n\'a pas Réussi  ',style: TextStyle(color:Colors.redAccent[700],fontFamily: 'Barlow' ,fontSize: 50.0 ),),
              Container(
                padding: EdgeInsets.only(top:25.0),
                width: 65.0.w,
              child: Icon(Icons.error,color: Colors.redAccent[700],size: 30.0.w,)),
              Padding(
                padding: const EdgeInsets.only(top:32),
                child: ButtonTheme(
                          disabledColor: Colors.black12,
                        
 
                 height: 55.0,
                 
                 minWidth: 70.0.w,child:  FlatButton(
                   
                    disabledColor: Colors.black12,
  disabledTextColor: Colors.blueGrey,
                   shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50.0) ),
                   
                 color: Colors.redAccent[700],
                 onPressed: ()
                  {
               
                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Plans(null)), (route) => false);
                   },
                 child:Text('Retour',
           style: TextStyle(
                 color: Colors.white,
                 fontSize: 20.0,
                 fontWeight: FontWeight.bold

                 ),))),
              )
            
            
            ],) ,),
            
            )
          



        ],),),),
    );
            });
            }
  }
