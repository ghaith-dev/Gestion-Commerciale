import'package:flutter/material.dart';
import 'package:gestion_commercial/Screens/Authentifcation/Login.dart';
import'package:sizer/sizer.dart';

import '../../Responsive.dart';
class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  final primaryColor= Color(0xff339999);
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Container(
          decoration: Responsive.isDesktop(context)? BoxDecoration(image: DecorationImage(
            image: AssetImage("Assets/Images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ):null,
                  child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            
            children: [
            Container(
              margin: EdgeInsets.only(top:20.0),
                     width: 90.0.w,
                      height:  Responsive.isDesktop(context)? MediaQuery.of(context).size.height*0.80:MediaQuery.of(context).size.height*0.55,
                        child: Card(elevation: 5.0,child:Column(children: [
          
                Text('Bienvenue',style: TextStyle(color:primaryColor,fontFamily: 'Barlow' ,fontSize: 50.0 ),),
                Container(
                  padding: EdgeInsets.only(top:25.0),
                  width: 65.0.w,
                child: Image.asset('Assets/Images/Welcome.png',fit: BoxFit.fill,)),
                Padding(
                  padding: const EdgeInsets.only(top:32),
                  child: ButtonTheme(
                            disabledColor: Colors.black12,
                          
 
                   height: 55.0,
                   
                   minWidth: 70.0.w,child:  FlatButton(
                     
                      disabledColor: Colors.black12,
  disabledTextColor: Colors.blueGrey,
                     shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50.0) ),
                     
                   color: Color(0xff339999),
                   onPressed: () {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>new Login()), (route) => false);  },
                   child:Text('Connectez-Vous',
             style: TextStyle(
                   color: Colors.white,
                   fontSize: 20.0,
                   fontWeight: FontWeight.bold

                   ),))),
                )
              
              
              ],) ,),
              
              )
            



          ],),),
        ),),
    );
  }
}