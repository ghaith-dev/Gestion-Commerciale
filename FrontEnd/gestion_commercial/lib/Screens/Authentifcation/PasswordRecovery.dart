import'package:flutter/material.dart';
import 'package:gestion_commercial/Responsive.dart';
import'package:gestion_commercial/Screens/Authentifcation/VerificationPassword.dart';
import 'package:sizer/sizer.dart';
import'package:gestion_commercial/Models/Authentification/User.dart';
import'package:gestion_commercial/Models/Authentification/User.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'dart:async';
class PasswordRecovery extends StatefulWidget {
  @override

  
  _PasswordRecoveryState createState() =>_PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  var message='';
  String email='';
  var x;
  final _emailContorller=TextEditingController();
  var valueanim=0;
  var valueanimtext=0;
  User user= User(null,null,null,null,null,null,null,null);
  
  @override
  Widget build(BuildContext context) {
        

    return Scaffold(
      backgroundColor: Colors.white,
      body: Responsive.isDesktop(context)==true?Row(children: [
        Expanded(
          flex:2,
          child: Container(child: PasswordForm(),color: Colors.white)),
          Expanded(
          flex:4,

          child: Container(color: Colors.primaryColor, child:Image.asset('Assets/Images/background.jpg' ,height: MediaQuery.of(context).size.height,fit: BoxFit.fill,),))
      ],)
      :PasswordForm()
      
    
    );}
  Widget PasswordForm(){
    return SafeArea(child: ListView(
              children: [Column(
          
           
          children: <Widget> [
           Padding(
             padding: const EdgeInsets.only(top:10),
             child: Container(
                 width: 250,
                 height: 250,
                 child: FittedBox(child: Image.asset("Assets/Images/password.png",),fit:BoxFit.fill,),
               ),
           ),
           Padding(
             padding:EdgeInsets.fromLTRB(15.0.w, 3.0.h, 15.0.w, 2.0.h),
                      child: Divider(
                                   indent: 5,         
                           endIndent: 5,
                          color: Color(0xff006666),
                          
                          thickness: 2.0,

                    ),
           ),
          Text(message,style: TextStyle(
                      color: Color(0xff006666),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily:'Barlow'
                  ),),
                
  Padding(
                      padding: EdgeInsets.fromLTRB(4.0.w, 1.0.h, 4.0.w, 0),
                      child: TextFormField(
                       
                    controller: _emailContorller,
            decoration: InputDecoration(
              
              focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xff339999),
                width: 3
              ),
                borderRadius: BorderRadius.circular(25.0)
                 
              ),
              enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 3
              ),
            
                borderRadius: BorderRadius.circular(25.0)
                 
              ),
              errorBorder:  UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red[400],
                width: 3
              ),
                borderRadius: BorderRadius.circular(25.0)
                 
              ),
              hintText: 'Adresse Email',
              prefixIcon:Icon(Icons.alternate_email,color: Colors.black,)
            ),
            

                    ),
                ),

Padding(
                      padding: EdgeInsets.fromLTRB(4.0.w, 6.0.h, 4.0.w, 2.0.h),
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
                
            x =await user.generateRecovryCode(_emailContorller.text),
            print(x.data['GeneratePasswordRecovryCode']),

                 if(x.data['GeneratePasswordRecovryCode']==1){Timer(Duration(milliseconds: 600), () {
      setState(() {
        email=_emailContorller.text;
        valueanim = 2;
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>VerificationPassword(email)), (route) => false);
      });
               }),}else{
                 setState(() {
                  message= 'Adresse e-mail non valide, vérifiez votre entrée';
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

}