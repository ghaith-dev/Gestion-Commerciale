import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import'package:sizer/sizer.dart';
 final primaryColor= Color(0xff339999);
 TextStyle Textstyle(){
   return TextStyle(color: Colors.black,fontSize: 20.0,fontFamily: 'Barlow');
 }
 TextStyle Titelstyle(){
   return TextStyle(color: primaryColor,fontSize: 25.0,fontFamily: 'Barlow');
 }
 String hitText;
 Icons icons;
 Icons suffixIcon;
 String suffixText;
 Color color;
 TextEditingController controller;
 String labeltext;
 TextInputType inputType;
Padding TextBox({hintText,icons,controller,inputType,suffixText, suffixIcon,color,validator,labeltext,maxline,inp}){ if(!kIsWeb) { return Padding(
                      padding: EdgeInsets.fromLTRB(0.0.w, 4.0.h, 4.0.w, 0),
                      child: TextFormField(
                        validator:  validator,
                        maxLines: maxline,
                       
                    controller: controller,
                    keyboardType: inputType,
                    
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 20,color: Colors.black),
              labelText: labeltext,
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
                color: color,
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
              hintText:hintText,
              suffixText:suffixText ,
          
              suffixIcon: Icon(suffixIcon,color: Colors.black,),
              
              
              prefixIcon:Icon(icons,color: Colors.black,)
            ),
            

                    ),
                );
}else{
 return  Padding(
                      padding: EdgeInsets.fromLTRB(0.0.w, 2.0.h, 4.0.w, 0),
                      child: TextField(
                        style: Textstyle(),
                    controller: controller,
                    keyboardType: inputType,
                    
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
              hintText:hintText,
              suffixText:suffixText ,
              suffixIcon:Icon(suffixIcon,color: Colors.black,),
              prefixIcon:Icon(icons,color: Colors.black,)
            ),
            

                    ),
                );
}}