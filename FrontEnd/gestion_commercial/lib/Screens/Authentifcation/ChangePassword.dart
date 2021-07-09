import 'dart:async';

import'package:flutter/material.dart';
import'package:sizer/sizer.dart';
import'package:gestion_commercial/Models/Authentification/User.dart';
import 'package:gestion_commercial/Screens/Authentifcation/Login.dart';

import '../../Responsive.dart';
User user= new User(null,null,null,null,null,null,null,null);
 
class PasswordChange extends StatefulWidget {
    String email;
PasswordChange(String email){
  this.email=email;

}
  @override
  _PasswordChangeState createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  
  var valueanim=0;
  var x;
  final _formkey= new GlobalKey<FormState>();
  final primaryColor= Color(0xff339999);
final passwordController=TextEditingController();
final retypepasswordController=TextEditingController();
final _emailContorller=TextEditingController();
var isclear=true;
  var istaped=0;
  var iconconpass=Icon(Icons.remove_red_eye);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Responsive.isDesktop(context)==true? Row(children: [
        
        Expanded(flex: 2,child: 
        Container(
          child: PasswordFormRecovry(),
          color: Colors.white,)
          ),
          Expanded(flex: 4,child: 
        Container(
          
          child:Image.asset('Assets/Images/background.jpg' ,height: MediaQuery.of(context).size.height,fit: BoxFit.fill,),
          color: Colors.primaryColor,)
          ),
          
          
          
          ])

        
          :PasswordFormRecovry()
      
      
    );
  }
  Widget PasswordFormRecovry(){
    return ListView(
        children: [
          SafeArea(
                  child: Form(
                    key: _formkey,
                                      child: Column(children:[
              
                Center(
                              child: Container(
                      width: 20.0.w,
                      height: Responsive.isDesktop(context)? 200:20.0.h,
                      child: Image.asset('Assets/Images/Logo.png')),
                )
            ,
            

              Padding(
                padding: EdgeInsets.fromLTRB(15.0.w, 0.0.h, 15.0.w, 3.0.h),
                                  child: Text('Insérez votre nouveau mot de passe',style: TextStyle(
                    color: Color(0xff006666),
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily:'Barlow'
                ),),
              ),
               Padding(
                 padding: EdgeInsets.fromLTRB(10.0.w, 0.0.h, 10.0.w, 0),
                                    child: Divider(
                             indent: 5,         
                     endIndent: 5,
                    color: Color(0xff006666),
                    
                    thickness: 2.0,

              ),
               ),
               
                Padding(
                      padding: EdgeInsets.fromLTRB(4.0.w, 4.0.h, 4.0.w, 0),
                      child: TextFormField(
                      validator: (value) {
                       
    if (!value.contains( RegExp('[0-9]'))&&!value.contains( RegExp('[A-Z]'))||value.length.compareTo(6)==-1){
  
      return 'le mot de passe doit contenir des caractères alphanumériques \n et sa longueur d\'au moins 6 caractères ';
    }else{
    return null;}
  },          
                       
                        controller: passwordController,
                        obscureText: isclear,
                    
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
              
              hintText: 'Mot de Passe ',
              suffixIcon: IconButton( icon: iconconpass,onPressed: (){
                setState(() {
                  
                  if(istaped==0){
                  iconconpass=Icon(Icons.remove_red_eye_outlined);
                  isclear=false;
                  istaped=1;
                  }
                  else{
                  iconconpass=Icon(Icons.remove_red_eye_rounded);
                  isclear=true;
                  istaped=0;}
                });
              },),
              prefixIcon:Icon(Icons.lock_rounded,color: Colors.black,)
            ),
            

                    ),
                ),
                
            Padding(
                      padding: EdgeInsets.fromLTRB(4.0.w, 4.0.h, 4.0.w, 0),
                      child: TextFormField(
                      validator: (value) {
                       
    if (passwordController.text.compareTo(retypepasswordController.text)!=0 ){
      
      return 'les deux mots de passe ne sont pas identiques ';
    }else{
      
    return null;}
  },          
                       
                        controller: retypepasswordController,
                        obscureText: isclear,
                    
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
              
              hintText: 'Retaper votre mot de passe ',
             
              prefixIcon:Icon(Icons.lock_rounded,color: Colors.black,)
            ),
            

                    ),
                ),
               
                   Padding(
                      padding: EdgeInsets.fromLTRB(4.0.w, Responsive.isDesktop(context)? 5.0.h:10.0.h, 4.0.w, 2.0.h),
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
                   x=  await user.passwordRecovry(widget.email, retypepasswordController.text),
                if(_formkey.currentState.validate()) {
           
                  setState((){
               
                valueanim=1;
                
                }),
                
                 if(x.data['PasswordRecovry']){Timer(Duration(milliseconds: 1200), () {
      setState(() {
        valueanim = 2;
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>new Login()), (route) => false);
      });
               }),}else{
                 setState(() {
        valueanim = 3;
        
        

      })
               }
               
               }
                }),
                ),
           ),                   ])
          )
      )
        ]);
  }
  Widget animateButton(){
    if(valueanim==0){
      return Text('Changer',
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
}}