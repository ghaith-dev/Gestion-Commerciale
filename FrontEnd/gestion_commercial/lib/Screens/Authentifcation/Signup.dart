import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gestion_commercial/Screens/Authentifcation/Plans.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sizer/sizer.dart';
import'package:gestion_commercial/Models/Authentification/User.dart';
import'package:gestion_commercial/Models/Authentification/Entreprise.dart';


import '../../Responsive.dart';
class SignUp extends StatefulWidget {
  User user;
  
  List<String> idModule=[];
  SignUp(List<String> idModule,User user){
this.idModule=idModule;
this.user=user;
  }
  @override
  _SignupState createState() => _SignupState();
}



class _SignupState extends State<SignUp> {
  @override
  String dropdownValue = 'Production';
  var valueanim=0;
final _formkey= new GlobalKey<FormState>();
final _companynameController=TextEditingController();
final _emailContorller=TextEditingController();
    
    final phonenumberController=TextEditingController();
    final faxnumberController=TextEditingController();
    final addressController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Responsive.isDesktop(context)==true? Row(children: [
        
        Expanded(flex: 2,child: 
        Container(
          child: SignUpForm(),
          color: Colors.white,)
          ),
          Expanded(flex: 4,child: 
        Container(
          
          child:Image.asset('Assets/Images/background.jpg' ,height: MediaQuery.of(context).size.height,fit: BoxFit.fill,),
          color: Colors.primaryColor,)
          ),
          
          
          
          ])

        
          :SignUpForm()
      
      
    );
  }
  Widget SignUpForm(){
    return ListView(
        children: [
          SafeArea(
                  child: Form(
                    key: _formkey,
                                      child: Column(children:[
              
                Center(
                              child: Container(
                      width: 20.0.w,
                      height: Responsive.isDesktop(context)? 6.5.h:20.0.h,
                      child: Image.asset('Assets/Images/Logo.png')),
                )
            ,
            

              Padding(
                padding: EdgeInsets.fromLTRB(15.0.w, 0.0.h, 15.0.w, 3.0.h),
                                  child: Text('Inscrivez-vous',style: TextStyle(
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
                      padding: EdgeInsets.fromLTRB(4.0.w, 4.0.h, 4.0.w, 0),
                      child: TextField(
                    controller: _companynameController,
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
              hintText: 'Nom de l`Entreprise',
              prefixIcon:Icon(Icons.business,color: Colors.black,)
            ),
            

                    ),
                ),
                
            Padding( padding: EdgeInsets.fromLTRB(4.0.w, 1.2.h, 4.0.w, 0.0.w),
              child: DropdownButtonHideUnderline(
              
                                  child: DropdownButtonFormField<String>(
                    
     
            
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              isDense: true, 
              hintText: 'Choisissez votre type de commerce',
              prefixIcon: Icon(Icons.ballot_rounded,color: Colors.black,),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black,
                    width: 3
                ),
                borderRadius: BorderRadius.circular(25.0)),
                 focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xff339999),
                    width: 3
                ),
                borderRadius: BorderRadius.circular(25.0))
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>['Production', 'Distribution', 'Fournisseur de Service']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
    ),
              )
              ),
            Padding(
                      padding: EdgeInsets.fromLTRB(4.0.w, 1.2.h, 4.0.w, 0),
                      child: TextField(
                    controller: _emailContorller,
            decoration: InputDecoration(
              
          isDense: true, 

               focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xff339999),
                width: 3,
              ),
                borderRadius: BorderRadius.circular(25.0)
                 
              ),
              enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 3
              ),
            
                borderRadius: BorderRadius.circular(50.00)
                 
              ),
              errorBorder:  UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red[400],
                width: 3
              ),
                borderRadius: BorderRadius.circular(25.0)
                 
              ),
              hintText: ' Adresse Email',
              prefixIcon:Icon(Icons.mail,color: Colors.black,)
            ),
            

                    ),

            ),
            Padding(
                      padding: EdgeInsets.fromLTRB(4.0.w, 1.2.h, 4.0.w, 0),
                      child: TextField(
                        controller: phonenumberController,
                    keyboardType: TextInputType.number,
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
            
              hintText: ' Numéro de Téléphone',
              prefixIcon:Icon(Icons.phone,color: Colors.black,)
            ),
            

                    ),

            ),
            Padding(
                      padding: EdgeInsets.fromLTRB(4.0.w, 1.2.h, 4.0.w, 0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                    controller: faxnumberController,
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
              hintText: 'Numéro de Fax',
              prefixIcon:Icon(Icons.local_print_shop_rounded,color: Colors.black,)
            ),
            

                    ),

            ),
            Padding(
                      padding: EdgeInsets.fromLTRB(4.0.w, 1.2.h, 4.0.w, 0),
                      child: TextField(
                    controller: addressController,
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
              hintText: 'Adresse',
              prefixIcon:Icon(Icons.pin_drop,color: Colors.black,)
            ),
            

                    ),

            ),
            Padding(
                padding: EdgeInsets.fromLTRB(4.0.w, 2.2.h, 4.0.w, 2.2.h),
                            child: ButtonTheme(
               height: 55.0,
               
               minWidth: 70.0.w,child: FlatButton(
                 shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50.0) ),
                 
               color: Color(0xff339999),
               child: animateButton(),
                onPressed: () async {
                  Entreprise entreprise= new Entreprise(null,_companynameController.text,dropdownValue.toString(),widget.idModule,int.parse(phonenumberController.text),_emailContorller.text,int.parse(faxnumberController.text),addressController.text);
                 var ent=  await entreprise.creatEntrprise();
                print(ent);
                 entreprise.setid(ent.data['CreateEntreprise']['id']);
                 print('identreprise:'+entreprise.id);
                 print('nomentreprise:'+entreprise.nomLegal);
                

                 print('username:'+widget.user.nom);
                 print('userid:'+widget.user.id);
                 var x= await widget.user.setIdEnt(entreprise.id);
                 print(x);
               if(x.data['SetIdEnt']['IdEnt']!=null) {setState((){
                
                valueanim=1;
                  }
                );}
                 if(x.data!=null&&ent.data!=null){
                   Timer(Duration(milliseconds: 1200), () {
      setState(() {
        valueanim = 2;
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>new Plans(widget.user,idEntreprise: ent.data['CreateEntreprise']['id'].toString(),)), (route) => false);
      });
               });}else{
                 setState(() {
        valueanim = 3;
        
        

      });
                    
                    }
                }
                )
                ),
            )
            ]
             ),
                  ),
          ),
        ],);
  }
  reb()=>build(context);
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