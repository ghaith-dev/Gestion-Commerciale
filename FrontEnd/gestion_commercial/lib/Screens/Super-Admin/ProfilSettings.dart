import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gestion_commercial/Models/Authentification/User.dart';
import 'package:gestion_commercial/Screens/Super-Admin/Style/TextStyle.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/prefer_universal/html.dart' as html;
import 'package:sizer/sizer.dart';
class ProfilSettings extends StatefulWidget {
 
  @override
  _ProfilSettingsState createState() => _ProfilSettingsState();
   User user ;
  ProfilSettings({this.user});
}

class _ProfilSettingsState extends State<ProfilSettings> {
  var msgvalue=false;
   var message='';
   var wrong=0;
   var isclear=true;
   var image;
   Uint8List data;
String name = '';
  String error;
  pickImage() {
    final html.InputElement input = html.document.createElement('input');
    input
      ..type = 'file'
      ..accept = 'image/*';

    input.onChange.listen((e) {
      if (input.files.isEmpty) return;
      final reader = html.FileReader();
      reader.readAsDataUrl(input.files[0]);
      reader.onError.listen((err) => setState(() {
             error = err.toString();
          }));
      reader.onLoad.first.then((res) {
        final encoded = reader.result as String;
        // remove data:image/*;base64 preambule
        final stripped =
            encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');

        setState(() {
          name = input.files[0].name;
         
          data = base64.decode(stripped);
          uploadweb(data);
          error = null;
        });
      });
    });

    input.click();
  }
   void _initData() async{
     var x= await widget.user.getUserById();
     setState(() {
            widget.user=x;
            print(x.id); 
setState(() {
  nameController.text=widget.user.nom;

  prenomController.text=widget.user.prenom;
emaildController.text=widget.user.email;
phoneController.text=widget.user.phone.toString();
});
     });
   }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
   
       _initData();



  }
    final _formkey= new GlobalKey<FormState>();
var istaped=0;
  var iconconpass=Icon(Icons.remove_red_eye_rounded);
  int valueanim=0;
   File _image;
final picker = ImagePicker();
TextEditingController passwordController = new TextEditingController();
TextEditingController oldpasswordController = new TextEditingController();
TextEditingController nameController = new TextEditingController();
TextEditingController prenomController = new TextEditingController();
TextEditingController emaildController = new TextEditingController();
TextEditingController phoneController = new TextEditingController();
  Future getImage() async {
    final pickedFile =   await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
       if (kIsWeb) {
  image = Image.network(pickedFile.path);
} else {
  image = Image.file(File(pickedFile.path));
}
      } else {
        print('No image selected.');
      }});
  }
  upload(File imageFile) async {
   
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
 
    var length = await imageFile.length();


    var uri = Uri.parse("http://192.168.1.14:3000/upload");


    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(_image.path));

   
    request.files.add(multipartFile);

    
    var response = await request.send();
    
    print(response.statusCode);

   
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
  uploadweb(var imageFile) async {
   
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
 
    var length = await imageFile.length();


    var uri = Uri.parse("http://192.168.1.14:3000/upload");


    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(_image.path));

   
    request.files.add(multipartFile);

    
    var response = await request.send();
    
    print(response.statusCode);

   
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;

    var height=MediaQuery.of(context).size.height;
    if(!kIsWeb)
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, title:Text('Paramètres De Profil',style:TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'Barlow')),elevation: 0.0,iconTheme: IconThemeData(color:Colors.black)),
      body: SafeArea(
        
        child: ListView(children: [
          SizedBox( height: height*0.05,),
        Card(child:Column( children:[Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Padding(
            padding: const EdgeInsets.only(top:10),
            child: CircleAvatar(
             radius: 50.0 + 3.0,
             backgroundColor: Colors.primaryColor,
             
             child:_image != null
                    ? InkWell(
                      onTap: ()async {await getImage();
                      await upload(_image);
                      print('ok');
                      },
                                          child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            _image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                    )
             
             
             
             :CircleAvatar(
 backgroundImage: NetworkImage('http://192.168.1.13:3000/Images'+'/'+widget.user.photo),
radius: 50.0,
                          child: Container(
      
                 height: 80,
                            child: FittedBox(
                   
                              child: IconButton(icon: Icon(Icons.add_a_photo), 
                   onPressed: () async{
                     await getImage();
                             

                   },
                   color: Colors.white
                   
            ),
                 ),
               ),
             ),
             
             ),
          ),
        ],),
        TextBox(hintText: 'Nom',icons: Icons.text_format_sharp,controller:nameController,color: Colors.primaryColor ),
        TextBox(hintText: 'Prenom',icons: Icons.text_format_rounded,controller:prenomController,color: Colors.primaryColor),
        TextBox(hintText: 'Email',icons: Icons.alternate_email_rounded,controller:emaildController,color: Colors.primaryColor),
        TextBox(hintText: 'Phone',icons: Icons.phone,controller:phoneController,color: Colors.primaryColor),
        
        FlatButton(onPressed: ()=>{ 
          passwordController.clear(),
          oldpasswordController.clear(),
          wrong=0,
          
          showDialog(context:context,builder: (context)=>   StatefulBuilder(
                  builder: (BuildContext context, void Function(void Function()) setState) {  
                  return Dialog(child: Container(
            height: height*0.5,
                    child: Card(child: Form(key: _formkey,
                        child: Column(children: [
                          Padding(
                        padding: EdgeInsets.fromLTRB(4.0.w, 4.0.h, 4.0.w, 0),
                        child: TextFormField(
                           
                         
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
                
                hintText: 'Nouveau mot de passe ',
                suffixIcon: IconButton( icon: iconconpass,onPressed: (){
                           print('aaa');
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
                           
                         
                          controller: oldpasswordController,
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
                
                hintText: 'Ancien mot de passe ',
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
                   if(wrong==1)  Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text(' Ancien Mot de Pass Incorrect',style: TextStyle(color:Colors.red)),
                   )
                   else Text(''),
                Padding(
                              padding: EdgeInsets.fromLTRB(4.0.w, 5.0.h, 4.0.w, 2.0.h),
                              child:ButtonTheme(
                                disabledColor: Colors.black12,
                                
  
                       height: 55.0,
                       
                       minWidth: 90.0.w,child:  FlatButton(
                          disabledColor: Colors.black12,
  disabledTextColor: Colors.blueGrey,
                         shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50.0) ),
                         
                       color: Color(0xff339999),
                       child: Text('Changer Mot De Passe ',
               style: TextStyle(
                   color: Colors.white,
                   fontSize: 15.0,
                   fontWeight: FontWeight.bold

                   ),),
                        
                        onPressed:()async {
                           if(_formkey.currentState.validate()) {
                          widget.user.password=oldpasswordController.text;
                          var x= await   widget.user.updatePassword(passwordController.text);
                          if(x.data['UpdatePassword']==1){
                           Navigator.pop(context);
                          }else{
                            if(x.data['UpdatePassword']==-1){
                           setState(() {
                    
                    wrong=1;
                  });
                          }}
                           }
                          
                       }
                        
                       
                       
                       
                       ),
                        ),
                   )
              ],),
            ),),
          ),);
       })) } , child: Align(alignment: Alignment.bottomLeft,child: Text('Changer  le Mot De Passe',style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: 'Barlow'),))),
        Padding(
                      padding: EdgeInsets.fromLTRB(4.0.w, 5.0.h, 4.0.w, 2.0.h),
                      child:ButtonTheme(
                        disabledColor: Colors.black12,
                        
  
               height: 55.0,
               
               minWidth: 70.0.w,child:  FlatButton(
                  disabledColor: Colors.black12,
  disabledTextColor: Colors.blueGrey,
                 shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50.0) ),
                 
               color: Color(0xff339999),
               child: animateButton(),
                
                onPressed:()async {
                  _image==null ? null : FutureBuilder(future: upload(_image),builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
                             if(snapshot.connectionState==ConnectionState.waiting){
                                  return Container(child:AlertDialog(
content: Row(children: [Text('Uploading'),CircularProgressIndicator(),],) ,
      )); 
                             }

                   },);
                   widget.user.nom=nameController.text;
                   widget.user.prenom=prenomController.text;
                   widget.user.email=emaildController.text;
                   widget.user.phone=int.parse(phoneController.text);
                   widget.user.photo=_image== null  ?  widget.user.photo :'1020'+_image.path.split('/')[6].toString();
                   print(widget.user.photo);
                  var x=await widget.user.updateUser();
                  if(x.data['UpdateUser']){
                  setState((){
                  
                valueanim=1;
                  
                });}
                 if(valueanim==1){Timer(Duration(milliseconds: 1200), () {
      setState(() {
        valueanim = 2;
        
        //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Modules(widget.user)), (route) => false);
      });
      Timer(Duration(seconds: 3), () {
        setState(() {
          valueanim = 0;
        });
          
        });
               });}else{
                 setState(() {
        valueanim = 3;
        
        

      });
               }
               
               }
               ),
                ),
           )
        ]))



      ],),),
    );
    else return  Scaffold(
      
      body: Container(
        decoration: BoxDecoration(
          image:DecorationImage(image: AssetImage('Assets/Images/ProfileSetting.jpg'),
          fit: BoxFit.cover

          )
        ),
              child: SafeArea(
          
          child: Center(
            child: Container(
              padding: EdgeInsets.only(top:30),
              width: width/4,
              height: height*40,
              child: ListView(children: [
              Card(child:Column( children:[Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Padding(
              padding: const EdgeInsets.only(top:10),
              child: CircleAvatar(
               radius: 50.0 + 3.0,
               backgroundColor: Colors.primaryColor,
               
               child:_image != null
                      ? InkWell(
                        onTap: ()async {await getImage();
                        await upload(_image);
                        print('ok');
                        },
                                            child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                      )
               
               
               
               :CircleAvatar(
 backgroundImage:NetworkImage('http://192.168.1.13:3000/Images'+'/'+widget.user.photo) ,
radius: 50.0,
                            child: Container(
        
                   height: 80,
                              child: FittedBox(
                     
                                child: IconButton(icon: Icon(Icons.add_a_photo), 
                     onPressed: () async{
                       await pickImage();
                             

                     },
                     color: Colors.white
                     
              ),
                   ),
                 ),
               ),
               
               ),
            ),
          ],),
          TextBox(hintText: 'Nom',icons: Icons.text_format_sharp,controller:nameController,color: Colors.primaryColor ),
          TextBox(hintText: 'Prenom',icons: Icons.text_format_rounded,controller:prenomController,color: Colors.primaryColor),
          TextBox(hintText: 'Email',icons: Icons.alternate_email_rounded,controller:emaildController,color: Colors.primaryColor),
          TextBox(hintText: 'Phone',icons: Icons.phone,controller:phoneController,color: Colors.primaryColor),
          
          FlatButton(onPressed: ()=>{ 
            passwordController.clear(),
            oldpasswordController.clear(),
            wrong=0,
            
            showDialog(context:context,builder: (context)=>   StatefulBuilder(
                    builder: (BuildContext context, void Function(void Function()) setState) {  
                    return Dialog(child: Container(
                      width: width/4,
              height: height*0.6,
                      child: Card(child: Form(key: _formkey,
                          child: Column(children: [
                            Padding(
                          padding: EdgeInsets.fromLTRB(4.0.w, 4.0.h, 4.0.w, 0),
                          child: TextFormField(
                             
                           
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
                  
                  hintText: 'Nouveau mot de passe ',
                  suffixIcon: IconButton( icon: iconconpass,onPressed: (){
                             print('aaa');
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
                             
                           
                            controller: oldpasswordController,
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
                  
                  hintText: 'Ancien mot de passe ',
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
                     if(wrong==1)  Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(' Ancien Mot de Pass Incorrect',style: TextStyle(color:Colors.red)),
                     )
                     else Text(''),
                  Padding(
                                padding: EdgeInsets.fromLTRB(4.0.w, 5.0.h, 4.0.w, 2.0.h),
                                child:ButtonTheme(
                                  disabledColor: Colors.black12,
                                  
  
                         height: 55.0,
                         
                         minWidth: 90.0.w,child:  FlatButton(
                            disabledColor: Colors.black12,
  disabledTextColor: Colors.blueGrey,
                           shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50.0) ),
                           
                         color: Color(0xff339999),
                         child: Text('Changer Mot De Passe ',
                 style: TextStyle(
                     color: Colors.white,
                     fontSize: 15.0,
                     fontWeight: FontWeight.bold

                     ),),
                          
                          onPressed:()async {
                             if(_formkey.currentState.validate()) {
                            widget.user.password=oldpasswordController.text;
                            var x= await   widget.user.updatePassword(passwordController.text);
                            if(x.data['UpdatePassword']==1){
                             Navigator.pop(context);
                            }else{
                              if(x.data['UpdatePassword']==-1){
                             setState(() {
                      
                      wrong=1;
                    });
                            }}
                             }
                            
                         }
                          
                         
                         
                         
                         ),
                          ),
                     )
                ],),
              ),),
            ),);
         })) } , child: Align(alignment: Alignment.bottomLeft,child: Text('Changer  le Mot De Passe',style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: 'Barlow'),))),
          Padding(
                        padding: EdgeInsets.fromLTRB(4.0.w, 5.0.h, 4.0.w, 2.0.h),
                        child:ButtonTheme(
                          disabledColor: Colors.black12,
                          
  
                 height: 55.0,
                 
                 minWidth: 70.0.w,child:  FlatButton(
                    disabledColor: Colors.black12,
  disabledTextColor: Colors.blueGrey,
                   shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50.0) ),
                   
                 color: Color(0xff339999),
                 child: animateButton(),
                  
                  onPressed:()async {
                    _image==null ? null : FutureBuilder(future: upload(_image),builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
                               if(snapshot.connectionState==ConnectionState.waiting){
                                    return Container(child:AlertDialog(
content: Row(children: [Text('Uploading'),CircularProgressIndicator(),],) ,
        )); 
                               }

                     },);
                     widget.user.nom=nameController.text;
                     widget.user.prenom=prenomController.text;
                     widget.user.email=emaildController.text;
                     widget.user.phone=int.parse(phoneController.text);
                     widget.user.photo=_image== null  ?  widget.user.photo :'1020'+_image.path.split('/')[6].toString();
                     print(widget.user.photo);
                    var x=await widget.user.updateUser();
                    if(x.data['UpdateUser']){
                    setState((){
                    
                  valueanim=1;
                    
                  });}
                   if(valueanim==1){Timer(Duration(milliseconds: 1200), () {
        setState(() {
          valueanim = 2;
          showDialog(context: context, builder: (context)=>AlertDialog(content: Text('données modifier avec succés',style: Textstyle(),),actions: [FlatButton(onPressed: ()=>{
                           Navigator.pop(context)
                         }, child: Text('Ok'))],));
          //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Modules(widget.user)), (route) => false);
        });
        Timer(Duration(seconds: 3), () {
          setState(() {
            valueanim = 0;
          });
            
          });
                 });}else{
                   setState(() {
          valueanim = 3;
          
          

        });
                 }
                 
                 }
                 ),
                  ),
             )
          ]))



        ],),
            ),
          ),),
      ),
    );
  }
  static Widget circularImageWithBorder(String imgPath, double rad, double borderWidth, Color borderColor) {
  return CircleAvatar(
      radius: rad + borderWidth,
      backgroundColor: borderColor,
      child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                    
                      child: Image.network( imgPath,
                      
                       
                        width: 100,
                        height: 100,
                        
                        fit: BoxFit.fill,
                        
                      )));
}
Widget animateButton(){
    if(valueanim==0){
      return Text('Modifier',
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