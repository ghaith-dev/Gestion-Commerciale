import 'dart:async';

import'package:flutter/material.dart';
import 'package:gestion_commercial/Screens/Authentifcation/Plans.dart';
import 'package:webview_flutter/webview_flutter.dart';
import'package:gestion_commercial/Models/Authentification/Plan.dart';
import'package:gestion_commercial/Models/Authentification/User.dart';

import'./ResultScreen.dart';
import 'dart:io';

class PaymentScreen extends StatefulWidget {
  String token;
  Plan plan;
  User user;
  PaymentScreen(String token,Plan plan,User user){
    this.token=token;
    this.plan=plan;
    this.user=user;
  }
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var isLoding=true;
  var x;
  int prog;
   final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  void initState() {
    // TODO: implement initState
    super.initState();
        if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
      
        

  }
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
          body: SafeArea(
                      child:Stack(
                                              children: [WebView(
                         
        initialUrl:  'https://sandbox.paymee.tn/gateway/'+'${widget.token}',
        onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
            
          },
        onProgress: (int progress) {
          print("WebView is loading (progress : $progress%)");
         setState(() {
           prog=progress;
         });
            
          },
            
onPageStarted: (String url)async{
  
    if(url.contains('/loader')){
                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> new ResultScreen(widget.plan,widget.token,widget.user)), (route) => false);
                  
             
             }
            


},
 
         onPageFinished: (String url)async{
           
           setState(()  {
             
             isLoding=false;
             
           });
           
         },
         
      ),
      isLoding ? Center( child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(),
      SizedBox(height: 15,),
      Text(prog.toString()+'%',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)]),)
                    : Stack(),
                                               ] ),
    
      
                   
          ),
          
    );
  }
}