import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gestion_commercial/Models/Authentification/Role.dart';
import 'package:gestion_commercial/Responsive.dart';
import'package:gestion_commercial/Screens/Authentifcation/PasswordRecovery.dart';
import'package:gestion_commercial/Models/Authentification/User.dart';
import 'package:gestion_commercial/Screens/Super-Admin/DashboardSuperAdmin.dart';
import 'package:gestion_commercial/Screens/User/Userdashboard.dart';
import 'package:gestion_commercial/main.dart'as main;
import 'package:sizer/sizer.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  User user =new User(null,null,null,null,null,null,null,null);
 var valueanim=0;
 var x;
  final _formkey= new GlobalKey<FormState>();
  final primaryColor= Color(0xff339999);
final passwordController=TextEditingController();
final _emailContorller=TextEditingController();
var isclear=true;
  var istaped=0;
  var iconconpass=Icon(Icons.remove_red_eye);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body:  Responsive.isDesktop(context)==true? Row(children: [
        
        Expanded(flex: 2,child: 
        Container(
          child: LoginForm(),
          color: Colors.white,)
          ),
          Expanded(flex: 4,child: 
        Container(
          
          child:Image.asset('Assets/Images/background.jpg' ,height: MediaQuery.of(context).size.height,fit: BoxFit.fill,),
          color: Colors.primaryColor,)
          ),
          
          
          
          ])

        
          :LoginForm()
    );
  }
  Widget LoginForm(){
    return ListView(
        children: [
          SafeArea(
                  child: Form(
                    key: _formkey,
                                      child: Column(children:[
              
                Center(
                              child: Container(
                      width: 20.0.w,
                      height: 20.0.h,
                      child: Image.asset('Assets/Images/Logo.png')),
                )
            ,
            

              FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0.w, 0.0.h, 15.0.w, 1.0.h),
                                        child: Text('Connectez-vous',style: TextStyle(
                          color: Color(0xff006666),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily:'Barlow'
                      ),),
                    ),
                  ],
                ),
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
                      padding: EdgeInsets.fromLTRB(4.0.w, 5.0.h, 4.0.w, 0),
                      child: TextFormField(
                        validator: (value) {
    if (!value.contains('@')&&!value.contains('.')) {
      return 'Inserer un email valide ';
    }else{
    return null;
                        }},
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
                      padding: EdgeInsets.fromLTRB(4.0.w, 2.0.h, 4.0.w, 0),
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
                  padding: const EdgeInsets.only(top:2.0,left: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FlatButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context)=> new PasswordRecovery())); },highlightColor: primaryColor,
                      child: Row(
                        children: [
                          FittedBox(fit: BoxFit.fitWidth,child: Text("Mot de passe oublié ?",style: TextStyle(fontSize: 15.0,color:primaryColor,fontWeight: FontWeight.bold ),)),
                        ],
                      ),),
                    ],
                  ),
                ),
                   Padding(
                      padding: EdgeInsets.fromLTRB(4.0.w, 3.0.h, 4.0.w, 2.0.h),
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
                   x=await user.login(_emailContorller.text, passwordController.text),
                if(_formkey.currentState.validate()) {
           
                  setState((){
                  print(x);
                valueanim=1;
                
                }),
                
                 if(x.data['Login']!=null){Timer(Duration(milliseconds: 1200), () {
                User  userl = new User(
                    x.data['Login']['user']['id'],
                  x.data['Login']['user']['Nom'],
                  x.data['Login']['user']['Prenom'],
                  x.data['Login']['user']['Email'],
                  null,
                  x.data['Login']['user']['Photo'],
                  int.parse(x.data['Login']['user']['Phone'].toString()),
                   new Role(x.data['Login']['user']['Role']['id'],
                   x.data['Login']['user']['Role']['libelle']));
                   
main.userid=userl;
      setState(() {
        valueanim = 2;
         switch(x.data['Login']['user']['Role']['libelle']){
           case'SAdmin':{
Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>DashboardSuperAdmin()), (route) => false);
 break;
           }
           case'Chef-Entreprise':{
Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>UserDashboard(x: x,)), (route) => false);
 break;
           }
           case'Employee':{
Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>UserDashboard(x: x,)), (route) => false);
 break;
           }
         }
        
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
      return Text('Connexion',
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