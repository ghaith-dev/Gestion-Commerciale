import 'dart:io';

import 'package:flutter/foundation.dart';
import'package:flutter/material.dart';
import 'package:gestion_commercial/Models/Abonnement/Abonnement.dart';
import 'package:gestion_commercial/Models/Authentification/User.dart';
import 'package:gestion_commercial/Models/Authentification/Entreprise.dart';
import'package:sizer/sizer.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import '../../Responsive.dart';
import 'sales.dart';

import 'NavDrawer.dart';
class DashboardSuperAdmin extends StatefulWidget {
  @override
  _DashboardSuperAdminState createState() => _DashboardSuperAdminState();
}

class _DashboardSuperAdminState extends State<DashboardSuperAdmin> {
  @override
  var userNumber;
  var firmsNumber;
  var subscriptionNumber;
  var income;
  void _initData()async{
   Entreprise entreprise =new Entreprise(null,null,null,null,null,null,null,null);
    User user= new User(null,null,null,null,null,null,null,null);
    Abonnement subscription = new Abonnement();
    var y=await user.getUsers();
print(y);
    var z=await entreprise.getEntreprises();
    var t=await subscription.getIncome();
    var k=await subscription.getSubscriptions();
    
    setState(() {
     userNumber=y.data['getUsers'].length;
     firmsNumber=z.data['getEntreprises'].length;
     income=t;
     subscriptionNumber=k.data['getSubscriptions'].length;
    });
   

  }
  void initState() {
    _initData();
    // TODO: implement initState
    super.initState();
    
  }
  @override
  final primaryColor= Color(0xff339999);
  
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;

    var height=MediaQuery.of(context).size.height;

  

    return Scaffold(
     
      backgroundColor:Colors.white ,
      appBar: Responsive.isMobile(context)==true ? AppBar(backgroundColor: Colors.white, title:Text('Tableau de bord de SuperAdmin ',style:TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'Barlow')),elevation: 0.0 , leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu_rounded,color: Colors.black,size: 40.0,),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),):AppBar(backgroundColor: Colors.white, title:Text('Tableau de bord de SuperAdmin ',style:TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'Barlow')),elevation: 0.0 ),
        
        drawer: Responsive.isMobile(context)==true ?Container(
          child: NavDrawer(),
          width: width*0.65,
          ):null,
    
        body:Responsive.isMobile(context)==true ? DashBoard(width, height) 
        : Row(children: [
          Expanded(
            flex: 1,
             
            child: Container(
              color:Colors.white,
            child:NavDrawer()
          )),
          
          Expanded(
            flex: 4,
            
            child: Container(
            child:DashBoard(width, height),
          ))
        ],

        )
    
      ); 
    
  }
   Widget DashBoard( width,height){
     var size = MediaQuery.of(context).size;
 final double itemHeight = (size.height) / 2;
 final double itemWidth = size.width / 2;
    
     return Column(
          
          children:<Widget>[
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Row(
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.only(top:18.0),
                    child: Card(
                      
                      color: Colors.greenAccent,
                      child: Container(
                        width: width*0.37,
                        height: 165,
                        child: Column(
                          
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.group_rounded,size:45,color: Colors.white,),
                                ],
                              ),
                            )
                            ,

                            Padding(
                              padding: const EdgeInsets.only(left:0,top:10),
                              child: Align(alignment: Alignment.centerLeft,child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(child: Center(child: Text('Nombre d\'utilisateurs',style:TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold,fontFamily:'Barlow')))),
                              ],
                            )
                              )),
                              Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Align(alignment: Alignment.center,child:
                            Text('${userNumber}',style:TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,fontFamily:'Barlow'))
                              )),
                              ],
                              
                        ),

                      ),
                    ),
                  ),Padding(
                    padding: const EdgeInsets.only(top:18.0),
                    child: Card(
                      
                      color: Colors.amberAccent,
                      child: Container(
                        width: width*0.37,
                        height: 165,
                        child: Column(
                          
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.business,size:45,color: Colors.white,),
                                ],
                              ),
                            )
                            ,

                            Padding(
                              padding: const EdgeInsets.only(left:0,top:10),
                              child: Align(alignment: Alignment.centerLeft,child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                
                                Text('Nombre des sociétés',style:TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold,fontFamily:'Barlow')),
                              ],
                            )
                              )),
                              Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Align(alignment: Alignment.center,child:
                            Text('$firmsNumber',style:TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,fontFamily:'Barlow'))
                              )),
                              ],
                              
                        ),

                      ),
                    ),
                  )
                ],),
              ),
Padding(
  padding: const EdgeInsets.only(left:8.0),
  child:   Row( 
  
                children: [
  
                  
  
                  Padding(
  
                    padding: const EdgeInsets.only(top:0),
  
                    child: Card(
  
                      
  
                      color: Colors.blueAccent,
  
                      child: Container(
  
                        width: width*0.37,
  
                        height:165,
  
                        child: Column(
  
                          
  
                          children: [
  
                            Padding(
  
                              padding: const EdgeInsets.only(top:10),
  
                              child: Row(
  
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  
                                children: [
  
                                  Icon(Icons.payment,size:45,color: Colors.white,),
  
                                ],
  
                              ),
  
                            )
  
                            ,
  
  
  
                            Padding(
  
                              padding: const EdgeInsets.only(left:0,top:10),
  
                              child: Align(alignment: Alignment.centerLeft,child:
  
                            Row(
  
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  
                              children: [
  
                                Text('Nombre d\'Abonnement',style:TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold,fontFamily:'Barlow')),
  
                              ],
  
                            )
  
                              )),
  
                              Padding(
  
                              padding: const EdgeInsets.only(top:10),
  
                              child: Align(alignment: Alignment.center,child:
  
                            Text('${subscriptionNumber}',style:TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,fontFamily:'Barlow'))
  
                              )),
  
                              ],
  
                              
  
                        ),
  
  
  
                      ),
  
                    ),
  
                  ),Padding(
  
                    padding: const EdgeInsets.only(top:0.0),
  
                    child: Card(
  
                      
  
                      color: Colors.redAccent,
  
                      child: Container(
  
                        width: width*0.37,
  
                        height: 165,
  
                        child: Column(
  
                          
  
                          children: [
  
                            Padding(
  
                              padding: const EdgeInsets.only(top:10),
  
                              child: Row(
  
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  
                                children: [
  
                                  Icon(Icons.attach_money_rounded,size:45,color: Colors.white,),
  
                                ],
  
                              ),
  
                            )
  
                            ,
  
  
  
                            Padding(
  
                              padding: const EdgeInsets.only(left:0,top:10),
  
                              child: Align(alignment: Alignment.centerLeft,child:
  
                            Row(
  
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  
                              children: [
  
                                Text('Les Revenus  ',style:TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold,fontFamily:'Barlow')),
  
                              ],
  
                            )
  
                              )),
  
                              Padding(
  
                              padding: const EdgeInsets.only(top:10),
  
                              child: Align(alignment: Alignment.center,child:
  
                            Text('${income} DT',style:TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,fontFamily:'Barlow'))
  
                              )),
  
                              ],
  
                              
  
                        ),
  
  
  
                      ),
  
                    ),
  
                  )
  
                ],),
),

       Expanded(
              //width: width,
              //height:height*0.30,
              child: SfCartesianChart(
       enableAxisAnimation: true,
       
               primaryXAxis: CategoryAxis(),
               title: ChartTitle(text: 'Analyse Annuelle Des Revenus en DT',textStyle: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold,fontFamily:'Barlow')), //Chart title.
               legend: Legend(isVisible: true,position: LegendPosition.bottom),
               

               backgroundColor: Colors.white, // Enables the legend.
               tooltipBehavior: TooltipBehavior(enable: true), // Enables the tooltip.
               series: <LineSeries<SalesData, String>>[
        LineSeries<SalesData, String>(
            dataSource: [
              SalesData('Jan', 35),
              SalesData('Feb', 28),
              SalesData('Mar', 34),
              SalesData('Apr', 32),
              SalesData('May', 40),
              SalesData('Avr', 35),
              SalesData('Mai', 28),
              SalesData('Jun', 34),
              SalesData('Juill', 32),
              SalesData('Sept', 40),
              SalesData('Oct', 28),
              SalesData('Nov', 234),
              SalesData('Dec', 32),
              
            ],
            color: primaryColor,
            name: 'Revenus',
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            dataLabelSettings: DataLabelSettings(isVisible: true,) // Enables the data label.
        )
               ]
       ),

            )],
     );
   }
}
