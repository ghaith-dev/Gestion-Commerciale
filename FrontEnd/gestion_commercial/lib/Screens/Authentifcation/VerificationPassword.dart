import 'dart:async';

import 'package:flutter/material.dart';
import'package:sizer/sizer.dart';
import'package:gestion_commercial/Screens/Authentifcation/ChangePassword.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import'package:gestion_commercial/Models/Authentification/User.dart';

import '../../Responsive.dart';
class VerificationPassword extends StatefulWidget {
  String email;

  VerificationPassword(String email){
    this.email=email;
  }
  @override
  _VerificationPasswordState createState() => _VerificationPasswordState();
}

class _VerificationPasswordState extends State<VerificationPassword> {
  @override
   
  String code='';
   var message='Veuillez saisir le code à 6 chiffres ';

  var x;
  User user = new User(null,null,null,null,null,null,null,null);
     var valueanim=0;
     var valueanimtext=0;
    
                                     
     @override
    Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
     body:
      Responsive.isDesktop(context)==true? Row(children: [
        
        Expanded(flex: 2,child: 
        Container(
          child: PasswordcodeValidation(),
          color: Colors.white,)
          ),
          Expanded(flex: 4,child: 
        Container(
          
          child:Image.asset('Assets/Images/background.jpg' ,height: MediaQuery.of(context).size.height,fit: BoxFit.fill,),
          color: Colors.primaryColor,)
          ),
          
          
          
          ])

        
          :PasswordcodeValidation()
                   
                
                   
                 
               
                 
    );}
                 
                 Widget PasswordcodeValidation(){
                   return SafeArea(child: ListView(
              children: [Column(
          
           
          children: <Widget> [
           Padding(
             padding: const EdgeInsets.only(top:10),
             child: Container(
                 width: 200,
                 height: 200,
                 child: FittedBox(child: Image.asset("Assets/Images/password.png",),fit:BoxFit.fill,),
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
                                    child: Text(message
                                     ,style: TextStyle(
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
    length: 6,

  
    onCompleted: (String value) {
    setState(() {
        code=value;
    });
    },
     onEditing: (bool value) {
    setState(() {
        valueanim=0;
    });
    },
 )   ,),
    
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
                                  
                                 x= await user.checkRecovryCode(widget.email, int.parse(code)),
                                 setState((){
                                 
                               valueanim=1;
                               
                               }),
                               
                                if(x.data['checkRecovryCode']==1){Timer(Duration(milliseconds: 1200), () {
                     setState(() {
                       valueanim = 2;
                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>PasswordChange(widget.email)), (route) => false);
                     });
                              }),}else{
                                setState(() {
                                  if(x.data['checkRecovryCode']==0){
                                    message='Code Incorrect';

                                  }else{
                                 message='Votre code est expiré';
                                  }
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
               
                 Widget animateButton() {
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
                 }
