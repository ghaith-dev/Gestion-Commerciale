import'package:flutter/material.dart';
import'package:gestion_commercial/Screens/Authentifcation/Modules.dart';
import 'package:sizer/sizer.dart';
import'package:gestion_commercial/Models/Authentification/User.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'dart:async';

import '../../Responsive.dart';
class VerificationScreen extends StatefulWidget {
  @override
  User user;
  VerificationScreen(User user){
  this.user=user;
  }
  _VerificationScreenState createState() =>_VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String code='';
  
  var valueanim=0;
  var valueanimtext=0;
  @override
  Widget build(BuildContext context) {
        widget.user;


    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Responsive.isDesktop(context)==true? Row(children: [
        
        Expanded(flex: 2,child: 
        Container(
          child: VerificationScreen(),
          color: Colors.white,)
          ),
          Expanded(flex: 4,child: 
        Container(
          
          child:Image.asset('Assets/Images/background.jpg' ,height: MediaQuery.of(context).size.height,fit: BoxFit.fill,),
          color: Colors.primaryColor,)
          ),
          
          
          
          ])

        
          :VerificationScreen()
      
      
    );
      
      
    
  }
  Widget VerificationScreen(){
   return SafeArea(child: ListView(
              children: [Column(
          
           
          children: <Widget> [
           Padding(
             padding: const EdgeInsets.only(top:10),
             child: Container(
                 width: 200,
                 height: 200,
                 child: FittedBox(child: Image.asset("Assets/Images/logov.png",),fit:BoxFit.fill,),
               ),
           ),
           Padding(
             padding:EdgeInsets.fromLTRB(15.0.w, 5.0.h, 15.0.w, 3.0.h),
                      child: Divider(
                                   indent: 5,         
                           endIndent: 5,
                          color: Color(0xff006666),
                          
                          thickness: 2.0,

                    ),
           ),
           Padding(
                  padding: EdgeInsets.fromLTRB(15.0.w, 0.0.h, 15.0.w, 1.0.h),
                                    child: Text('Veuillez saisir le code à 4 chiffres envoyé à '+
                                     ' ${widget.user.email}. ',style: TextStyle(
                      color: Color(0xff006666),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily:'Barlow'
                  ),),
                ),
           Padding(
             padding:  EdgeInsets.fromLTRB(0.0.w, 1.0.h, 0.0.w, 0),
             child: VerificationCode(
               
  textStyle: TextStyle(fontSize: 20.0, color: Colors.black),

  underlineColor: Color(0xff006666),
  keyboardType: TextInputType.number,
  length: 4,

  
  onCompleted: (String value) {
    setState(() {
        code=value;
    });
  },
  onEditing: (bool value) {
    setState(() {
        
    });
  },
),),
Padding(
    padding: const EdgeInsets.only(top:15.0),
    child: TextButton(
      onPressed: ()async { var x= await widget.user.resendCode();
      if(x==true){
        setState(() {
          valueanimtext=1;
        });
Timer(Duration(milliseconds: 1200), () {
      setState(() {
        valueanim = 0;
        
      });
               });
      }
       },
      child: 
       Text( 'Renvoyer le Code',
        style: TextStyle(
              fontSize: 14.0,
              decoration: TextDecoration.underline,
              color: Color(0xff006666))),
    ),
  ),
Padding(
                      padding: EdgeInsets.fromLTRB(4.0.w, 10.0.h, 4.0.w, 2.0.h),
                      child:ButtonTheme(
                        disabledColor: Colors.black12,
                        
  
               height: 55.0,
               
               minWidth: 70.0.w,child:  FlatButton(
                  disabledColor: Colors.black12,
  disabledTextColor: Colors.blueGrey,
                 shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50.0) ),
                 
               color: Color(0xff339999),
               child: animateButton(),
                
                onPressed:()async =>{
                   
                  
                  setState((){
                  
                valueanim=1;
                
                }),
                 if(await  widget.user.getverified(int.parse(code))==true){Timer(Duration(milliseconds: 1200), () {
      setState(() {
        valueanim = 2;
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Modules(widget.user)), (route) => false);
      });
               }),}else{
                 setState(() {
        valueanim = 3;
        
        

      })
               }
               
               }
               ),
                ),
           ),
           
          ],
          ),
               ] ),
      
      );
  }
  Widget animateButton(){
    if(valueanim==0){
      return Text('Confirmer',
           style: TextStyle(
               color: Colors.white,
               fontSize: 20.0,
               fontWeight: FontWeight.bold

               ),);
    }else{
      if(valueanim==1){
        return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
         
    }else{
      if(valueanim==2)
      return Icon(Icons.check, color: Colors.white ,size: 30,);
      else
      return Icon(Icons.close, color: Colors.white ,size: 30,);
    }
      }
    }
Widget animateText(){
    if(valueanimtext==0){
      Text( 'Renvoyer le Code',
        style: TextStyle(
              fontSize: 14.0,
              decoration: TextDecoration.underline,
              color: Color(0xff006666)));
    }else{
      if(valueanimtext==1){
        return Text( 'le code a été  envoyer ',
        style: TextStyle(
              fontSize: 14.0,
              decoration: TextDecoration.underline,
              color: Color(0xff006666)));
         
    }
    }
  }
}