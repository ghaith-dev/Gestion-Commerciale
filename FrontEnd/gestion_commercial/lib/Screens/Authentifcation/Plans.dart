import 'package:flutter/material.dart';
import 'package:gestion_commercial/Models/Abonnement/Abonnement.dart';
import 'package:gestion_commercial/Screens/Authentifcation/ChangePassword.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sizer/sizer.dart';
import'package:gestion_commercial/Screens/Payment/PaymentScreen.dart';
import'package:gestion_commercial/Models/Authentification/Plan.dart';
import'package:gestion_commercial/Models/Authentification/User.dart';

import '../../Responsive.dart';

class Plans extends StatefulWidget {
  User usre;
  var idEntreprise;
  Plans(User user,{this.idEntreprise}){
    this.usre=user;
  }
  @override
  _PlansState createState() => _PlansState();
}
int x;
class _PlansState extends State<Plans>   {
  
Plan plans;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
 plans = new Plan(null,null,null,null);
  }
 
  @override
  Widget build(BuildContext context)  {
    return FutureBuilder(future: plans.getPalns(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  

            if(plans.result==null){
              return Scaffold(body:Center(child: CircularProgressIndicator(),));
            }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: Responsive.isDesktop(context)? BoxDecoration(image: DecorationImage(
            image: AssetImage("Assets/Images/person.jpg"),
            fit: BoxFit.cover,
          ),
        ):null,
        child: SafeArea(child: ListView.builder ( 
          scrollDirection: Axis.horizontal,


          itemCount: plans.result.data['getPlans'].length,
        
            itemBuilder:  (BuildContext context, int index)  { 
            Plan pln= new Plan(plans.result.data['getPlans'][index]['id'], plans.result.data['getPlans'][index]['planType'], double.parse(plans.result.data['getPlans'][index]['prix'].toString()), plans.result.data['getPlans'][index]['duree']);
              return
                Padding(
              padding: const EdgeInsets.all(5.0),
              child:
                
                
                  Card(
                    
                    margin:EdgeInsets.only(top:10.0.h,bottom: 20.0.h) ,
                    color: Colors.white,
                    elevation: 10.0,
                    shadowColor: Colors.primaryColor,
                    child: Container(
                        width: 65.0.w,
                        height: 28.0.h,
                        child: Column(
                          
                          crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text('${pln.planType}',style:TextStyle(
                              color: Color(0xff006666),
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontFamily:'Barlow'
                        ),),
                            ),
                                              ),
                        Padding(
                          padding: const EdgeInsets.only(left:15.0),
                          child: Text('Prix: ${pln.prix} DT TTC',style:TextStyle(
                              color: Color(0xff006666),
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              fontFamily:'Barlow'
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0,10.0,0,0),
                          child: Text('Durée: ${pln.duree} Jours',style:TextStyle(
                              color: Color(0xff006666),
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              fontFamily:'Barlow'
                          ),),
                        ),
                           Center(
                                                      child: Padding(
                  padding: EdgeInsets.fromLTRB(4.0.w, 3.2.h, 4.0.w, 2.2.h),
                                child: ButtonTheme(
                 height: 55.0,
                 
                 minWidth: 70.0.w,child: FlatButton(
                   shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50.0) ),
                   
                 color: Color(0xff339999),
                 child: Text('S''\'''abonner',
             style: TextStyle(
                 color: Colors.white,
                 fontSize: 20.0,
                 fontWeight: FontWeight.bold

                 ),),
                  onPressed: () async{
                    if(pln.prix==0){
                     Abonnement abonn = new Abonnement(entreprise:widget.usre,plan: pln );
                     await abonn.createSubscription();
                    Navigator.pushNamedAndRemoveUntil(context, '/Welcome', (route) => false);
                    }else{

                     var token= await pln.payerPlan();
                     print(token);
                     
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>new PaymentScreen(token,pln,user)));
                          
                      }}
                  ,)),
              ),
                           )
                          
                                              ]),
                      ),
                  )); 
              },
            
            
        ),),
      )
      ,);
      });
    
  }
}