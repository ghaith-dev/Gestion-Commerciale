import 'dart:async';

import 'package:flutter/material.dart';
import'package:gestion_commercial/Models/Authentification/User.dart';
import'package:gestion_commercial/Screens/Authentifcation/Login.dart';
import'package:gestion_commercial/Screens/Authentifcation/VerificationScreen.dart';


import 'package:sizer/sizer.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../Responsive.dart';

class UserSignup extends StatefulWidget {
  
  
  @override
  _UserSignupState createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  
   User user;
  
var valueanim=0;
  final primaryColor= Color(0xff339999);

   var msgvalue=false;
   var message='';
  final _formkey= new GlobalKey<FormState>();
  final _nomController=TextEditingController();
final _prenomContorller=TextEditingController();
    var value=false;
     var value2=false;
     var value3=false;
     var value4=false;
     var value5=false;
    
    var emailController=TextEditingController();
    final phoneController=TextEditingController();
    var passwordController=TextEditingController();
  var isclear=true;
  var istaped=0;
  var iconconpass=Icon(Icons.remove_red_eye_rounded);
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      body:  Responsive.isDesktop(context)==true? Row(children: [
        
        Expanded(flex: 2,child: 
        Container(
          child: UserSignUpForm(),
          color: Colors.white,)
          ),
          Expanded(flex: 4,child: 
        Container(
          
          child:Image.asset('Assets/Images/background.jpg' ,height: MediaQuery.of(context).size.height,fit: BoxFit.fill,),
          color: Colors.primaryColor,)
          ),
          
          
          
          ])

        
          :UserSignUpForm()
      
    );
  }
  Widget UserSignUpForm(){
    return Form(
        key:_formkey,
              child: SafeArea(
                child: ListView(children:<Widget> [
              Center(
                child:Column(
                  children: <Widget>[
                     Center(
                                child: Container(
                        width: 20.0.w,
                        height: Responsive.isDesktop(context)? 100:20.0.h,
                        child: Image.asset('Assets/Images/Logo.png')),
                  ),
Padding(
                  padding: EdgeInsets.fromLTRB(15.0.w, 0.0.h, 15.0.w, 3.0.h),
                                    child: Text('Créer Un Compte',style: TextStyle(
                      color: Color(0xff006666),
                      fontSize: 30.0,
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
                  padding: const EdgeInsets.only(top:2.0,left: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context)=> new Login())); },highlightColor: primaryColor,
                      child: Text("Vous avez un compte?, Connectez-vous?",style: TextStyle(fontSize: 15.0,color:primaryColor,fontWeight: FontWeight.bold ),),),
                    ],
                  ),
                ),
Padding(
                      padding: EdgeInsets.fromLTRB(4.0.w, Responsive.isDesktop(context)?20:4.0.h, 4.0.w, 0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        onChanged: (text){
                          setState(() {
                            if(text==''){
                              value3=false;
                            }else{
                              value3=true;
                            }
                          });
                        },
                        
                        controller: _nomController,
                    
            decoration: InputDecoration(
              isDense: true, 
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
              hintText: 'Nom',
              prefixIcon:Icon(Icons.account_circle_rounded,color: Colors.black,)
            ),
            

                    ),
                ),
                Padding(
                      padding: EdgeInsets.fromLTRB(4.0.w, Responsive.isDesktop(context)?20:4.0.h, 4.0.w, 0),
                      child: TextField(
                        onChanged: (text){
                          setState(() {
                            if(text==''){
                              value4=false;
                            }else{
                              value4=true;
                            }
                          });
                        },
                       
                    controller: _prenomContorller,
            decoration: InputDecoration(
              isDense: true, 
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
              hintText: 'Prénom',
              prefixIcon:Icon(Icons.text_fields,color: Colors.black,)
            ),
            

                    ),
                ),
                 Padding(
                      padding: EdgeInsets.fromLTRB(4.0.w, Responsive.isDesktop(context)?20:4.0.h, 4.0.w, 0),
                      child: TextFormField(
                        
                        keyboardType: TextInputType.text,
                        validator: (value) {
    if (!value.contains('@')&&!value.contains('.')) {
      return 'Inserer un email valide ';
    }else{if(msgvalue==true){
      return message;
    }}
    return null;
  },
                         onChanged: (text){
                          setState(() {
                            if(text==''){
                              value=false;
                            }else{
                              value=true;
                            }
                          });
                        },
                    controller: emailController,
                    
            decoration: InputDecoration(
              
              isDense: true, 
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
              
              hintText: 'Adresse mail',
              prefixIcon:Icon(Icons.alternate_email_rounded,color: Colors.black,)
            ),
            

                    ),
                ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(4.0.w, Responsive.isDesktop(context)?20:4.0.h, 4.0.w, 0),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: (text){
                          setState(() {
                            if(text==''){
                              value5=false;
                            }else{
                              value5=true;
                            }
                          });
                        },
                       
                    controller: phoneController,
            decoration: InputDecoration(
              
              isDense: true, 
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
              
              hintText: ' Téléphone',
              prefixIcon:Icon(Icons.phone,color: Colors.black,)
            ),
            

                    ),
                ),
                 Padding(
                      padding: EdgeInsets.fromLTRB(4.0.w, Responsive.isDesktop(context)?20:4.0.h, 4.0.w, 0),
                      child: TextFormField(
                         onChanged: (text){
                          setState(() {
                            if(text==''){
                              value2=false;
                            }else{
                              value2=true;
                            }
                          });
                        },
                       
                        controller: passwordController,
                        obscureText: isclear,
                    validator: (value) {
    if (!value.contains( new RegExp(r'[a-z]'))&&!value.contains(new RegExp(r'[0-9]'))||value.length<6) {
      return 'le mot de passe doit contenir des caractères alphanumériques et sa longueur d\'au moins 6 caractères ';
    }else{if(msgvalue==true){
      return message;
    }}
    return null;
  },
            decoration: InputDecoration(
              
              isDense: true, 
            
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
                      padding: EdgeInsets.fromLTRB(4.0.w, 4.0.h, 4.0.w, 2.0.h),
                      child:ButtonTheme(
                        disabledColor: Colors.black12,
                        
  
               height: 55.0,
               
               minWidth: 70.0.w,child:  FlatButton(
                  disabledColor: Colors.black12,
  disabledTextColor: Colors.blueGrey,
                 shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50.0) ),
                 
               color: Color(0xff339999),
               child:animateButton(),
                
                
                onPressed:button()
               ),
                ),
),
              ],) ,)

          ],),
        ),
      );
  }
 button(){
   if(value==false||value2==false||value3==false||value4==false||value5==false){
     return null;
   }else{
     return  () async {
       if(_formkey.currentState.validate()) {
         setState((){
                  
                valueanim=1;
                
                });
         user= new User(null, _nomController.text, _prenomContorller.text, emailController.text, passwordController.text, "main.jpg", int.parse(phoneController.text),  null);
         var result =await user.createUser();
    print(result.data['CreatUser']);
         if(result.data['CreatUser']['user']!=null){
            Timer(Duration(milliseconds: 200), () {
           user.setId(result.data['CreatUser']['user']['id'].toString());
           setState(() {
        valueanim = 2;
        
      });
           Navigator.push(context,MaterialPageRoute(builder: (context)=>new VerificationScreen(user)));}
         );
                
      
            
                 
         }else{
         setState(() {
        valueanim = 3;});
          _showMyDialog(result.data['CreatUser']['Msg']);

         }



          
     
       
       }
     };
   }
 }
  Widget animateButton(){
    if(valueanim==0){
      return Text('S`inscrire',
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
Future<void> _showMyDialog( String msg) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(msg),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Icon(Icons.close,size: 80.0,color: Colors.red,),
              Text(msg),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('D`accord'),
            onPressed: () {
               setState(() {
        valueanim = 0;});
              Navigator.of(context).pop();
              
            },
          ),
        ],
      );
    },
  );
}
  }
