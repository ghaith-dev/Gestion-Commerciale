
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import'package:gestion_commercial/Screens/Authentifcation/Signup.dart';
import'package:gestion_commercial/Models/Authentification/Module.dart';
import'package:gestion_commercial/Models/Authentification/User.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import'package:sizer/sizer.dart';

import '../../Responsive.dart';
class Modules extends StatefulWidget {
  @override
  Module module=new Module(null,null);
User user;
  Modules(User user){
    this.user=user;

  }
  _ModulesState createState() => _ModulesState();
}

class _ModulesState extends State<Modules> {
  @override
  List<int> selectedIndex=[];
   Module module;
   var count;
QueryResult result;
  List<String> idModule=[];
   List<bool> taped=[];
 
  
    void  init()async{
         module=new Module(null,null);
       result= await module.getModules();
       
       print(result);
         }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
      init();
  }
  var priamrycolor = Color(0xff339999);
  @override
  Widget build(BuildContext context) {
    
   
  
     return FutureBuilder(
       future: module.getModules(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  

            if(module.result==null){
              return Scaffold(body:Center(child: CircularProgressIndicator(),));
            }
            return Scaffold(
          body:Responsive.isDesktop(context)==true? Row(children: [
        
        Expanded(flex: 2,child: 
        Container(
          child:Container(
          
          child:Image.asset('Assets/Images/Modules.jpg' ,height: MediaQuery.of(context).size.height,fit: BoxFit.fill,),
          color: Colors.primaryColor,)
          )
          ),
          Expanded(flex: 4,child: MosulesForm(),
        
          ),
          
          
          
          ])

        
          :MosulesForm()
      
      

      ); 



            
           



          
            });
         


      
    
  }
  Widget MosulesForm(){
    return SafeArea(child: 
            
              
                  
                
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children:[ Expanded(

                                                    child: Center(
                                                      child: ListView.builder(
                                 scrollDirection: Axis.horizontal,
                                   
                            itemCount:result.data['getmoduls'].length ,
                            itemBuilder: (BuildContext context, int index) {  
                             Module mdu = new Module(module.result.data['getmoduls'][index]['id'],module.result.data['getmoduls'][index]['libelle'],);
                              
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  
                                  radius: 70.0,
                              backgroundColor:priamrycolor ,
                              child: InkWell(
                                onTap: ()=>{
                                  setState((){
                      
                                  if(selectedIndex.contains(index)==false){
                      selectedIndex.add(int.parse(index.toString()));
                      print(selectedIndex);
                      
                      idModule.add('"'+mdu.id+'"');
                      print(idModule);
                      
                      
                                  }else{
                      selectedIndex.remove(int.parse(index.toString()));
                      print(selectedIndex);
                      idModule.remove(mdu.id);
                      print(idModule);
                      
                      
                                  }
                                  })
                                },

                                child: animtab(mdu,index),
                                
                              ),
                            ),
                            
                              );
                              
                              } ,
                              
                          ),
                                                    ),
                        ),
                        
                        ]),
                    ),
                      Padding(
                        padding: const EdgeInsets.only(bottom:90.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                    padding: EdgeInsets.fromLTRB(4.0.w, 2.2.h, 4.0.w, 2.2.h),
                                child: ButtonTheme(
                   height: 55.0,
                   
                   minWidth: 70.0.w,child: FlatButton(
                     shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50.0) ),
                     
                   color: priamrycolor,
                   child: Text('Continuer',
               style: TextStyle(
                   color: Colors.white,
                   fontSize: 20.0,
                   fontWeight: FontWeight.bold

                   ),),
                    onPressed: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>new SignUp(idModule,widget.user)), (route) => false);
                    })),
                )
                        
                      ),
                      )],
                )
                
              );
  }
  animtab(Module mdu,index){
    
     return selectedIndex.contains(index) ?  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[ Icon(Icons.check,size: 60.0,color: Colors.white,),
      SizedBox(height: 2.5,),
      Center(child: Text(mdu.libelle,style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold,fontFamily: 'Barlow',color: Colors.white),))
    
      
      ]):Padding(
        padding: const EdgeInsets.only(right:8.0),
        child: Text(mdu.libelle,style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold,fontFamily: 'Barlow',color: Colors.white),),
      );
    

      }
}