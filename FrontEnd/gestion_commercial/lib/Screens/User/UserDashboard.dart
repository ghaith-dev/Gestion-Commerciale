import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:gestion_commercial/Screens/Super-Admin/NavDrawer.dart';
import 'package:gestion_commercial/Screens/Super-Admin/Sales.dart';
import 'package:gestion_commercial/Screens/User/UserNavDrawer.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:responsive_table/responsive_table.dart';
import'package:gestion_commercial/Models/Authentification/Entreprise.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:gestion_commercial/main.dart'as main;
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../Responsive.dart';

class UserDashboard extends StatefulWidget {
  @override
  
  var x;
  _UserDashboardState createState() => _UserDashboardState();
  UserDashboard({this.x});
}

class _UserDashboardState extends State<UserDashboard> {
  @override



  




   

  @override
   Widget build(BuildContext context) {
     
     final List<ChartData> chartData = [
            ChartData('David', 50,),
            ChartData('Steve', 50,)
            
        ];
     return   Scaffold(
    resizeToAvoidBottomInset:false,
       appBar: Responsive.isMobile(context)==true ? AppBar(backgroundColor: Colors.white, title:Text('Tableau de Bord  ',style:TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'Barlow')),elevation: 0.0 , leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu_rounded,color: Colors.black,size: 40.0,),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),):AppBar(backgroundColor: Colors.white, title:Text('Tableau de bord de SuperAdmin ',style:TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'Barlow')),elevation: 0.0 ),
      drawer: Responsive.isMobile(context)==true ?Container(
          child: UserNavDrawer(x:widget.x,z:widget.x.data['Login']['user']['IdEnt']['id']),
          width: MediaQuery.of(context).size.width*0.65,
          ):null,
      body:(Responsive.isDesktop(context))? Row(
        children: [
          Expanded(flex:2,child: Container(child: UserNavDrawer(x:widget.x,z:widget.x.data['Login']['user']['IdEnt']['id']),color:Colors.white,)),
          Expanded(flex:5,child: Responsive.isDesktop(context)? Container(color: Colors.white,
          child:Row(
            children: [
              
              
              Expanded( flex:5 ,child:Column(
                children: [
                  Expanded( child :SizedBox(width: double.infinity,child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        title: ChartTitle(text: 'Analyse Annuelle De Stock en Quantité',textStyle: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold,fontFamily:'Barlow')), //Chart title.
                        series: <ChartSeries>[

                            LineSeries<SalesData, String>(
                                dataSource: [
                                    SalesData('Jan', 35, segmentColor:  Colors.red),
                                    SalesData('Feb', 28,segmentColor: Colors.green),
                                    SalesData('Mar', 34, segmentColor:Colors.blue),
                                    SalesData('Apr', 32,segmentColor: Colors.pink),
                                    SalesData('May', 40,segmentColor: Colors.black),
                                    SalesData('Juin', 35, segmentColor:  Colors.red),
                                    SalesData('Juill', 28,segmentColor: Colors.green),
                                    SalesData('Aout', 34, segmentColor:Colors.blue),
                                    SalesData('Sept', 32,segmentColor: Colors.pink),
                                    SalesData('Oct', 40,segmentColor: Colors.black),
                                    SalesData('Nov', 32,segmentColor: Colors.pink),
                                    SalesData('Dec', 40,segmentColor: Colors.black)
                                ],
                                // Bind the color for all the data points from the data source
                                pointColorMapper:(SalesData sales, _) => sales.segmentColor,
                                xValueMapper: (SalesData sales, _) => sales.year,
                                yValueMapper: (SalesData sales, _) => sales.sales
                            ),
                             
                        ]
            )
                ), flex:3),
                  Expanded( child :SizedBox(width: double.infinity,child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                         title: ChartTitle(text: 'Analyse Annuelle Des Achats en DT',textStyle: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold,fontFamily:'Barlow')), //Chart title.
                        series: <ChartSeries>[
                            LineSeries<SalesData, String>(
                                dataSource: [
                                  SalesData('Jan', 35, segmentColor:  Colors.red),
                                    SalesData('Feb', 28,segmentColor: Colors.green),
                                    SalesData('Mar', 34, segmentColor:Colors.blue),
                                    SalesData('Apr', 32,segmentColor: Colors.pink),
                                    SalesData('May', 40,segmentColor: Colors.black),
                                    SalesData('Juin', 35, segmentColor:  Colors.red),
                                    SalesData('Juill', 28,segmentColor: Colors.green),
                                    SalesData('Aout', 34, segmentColor:Colors.blue),
                                    SalesData('Sept', 32,segmentColor: Colors.pink),
                                    SalesData('Oct', 40,segmentColor: Colors.black),
                                    SalesData('Nov', 32,segmentColor: Colors.pink),
                                    SalesData('Dec', 40,segmentColor: Colors.black)
                                ],
                                // Bind the color for all the data points from the data source
                                pointColorMapper:(SalesData sales, _) => sales.segmentColor,
                                xValueMapper: (SalesData sales, _) => sales.year,
                                yValueMapper: (SalesData sales, _) => sales.sales
                            ),
                             
                        ]
            )
                ), flex:3),
                  Expanded( child :SizedBox(width: double.infinity,child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        title: ChartTitle(text: 'Analyse Annuelle Des Ventes en DT',textStyle: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold,fontFamily:'Barlow')), //Chart title.
                        series: <ChartSeries>[
                            LineSeries<SalesData, String>(
                                dataSource: [
                                    SalesData('Jan', 35, segmentColor:  Colors.red),
                                    SalesData('Feb', 28,segmentColor: Colors.green),
                                    SalesData('Mar', 34, segmentColor:Colors.blue),
                                    SalesData('Apr', 32,segmentColor: Colors.pink),
                                    SalesData('May', 40,segmentColor: Colors.black),
                                    SalesData('Juin', 35, segmentColor:  Colors.red),
                                    SalesData('Juill', 28,segmentColor: Colors.green),
                                    SalesData('Aout', 34, segmentColor:Colors.blue),
                                    SalesData('Sept', 32,segmentColor: Colors.pink),
                                    SalesData('Oct', 40,segmentColor: Colors.black),
                                    SalesData('Nov', 32,segmentColor: Colors.pink),
                                    SalesData('Dec', 40,segmentColor: Colors.black)
                                ],
                                // Bind the color for all the data points from the data source
                                pointColorMapper:(SalesData sales, _) => sales.segmentColor,
                                xValueMapper: (SalesData sales, _) => sales.year,
                                yValueMapper: (SalesData sales, _) => sales.sales
                            ),
                             
                        ]
            )
                ), flex:3)
                ],
              ) ),
              
              Expanded( flex:2,child: Column(children: [
                       
               SfCircularChart(
                  title: ChartTitle(text: 'Analyse  Des Charge vs Produit en %',textStyle: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold,fontFamily:'Barlow')),
                  legend: Legend(title:LegendTitle(text: 'Legend')  ),
                        series: <CircularSeries>[
                            // Render pie chart

                            PieSeries<ChartData, String>(
                                dataSource: chartData,
                                pointColorMapper:(ChartData data,  _) => data.color,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                

                            )
                        ]
                    )

              ],),),
              
              ],
          ) ,
          
          
          
          
          
          
          ):ListView(children: [Text('hahah')],))
          
        ],
      ) :
      Column(
                children: [
                  Expanded( child :SizedBox(width: double.infinity,child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        title: ChartTitle(text: 'Analyse Annuelle De Stock en Quantité',textStyle: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold,fontFamily:'Barlow')), //Chart title.
                        series: <ChartSeries>[

                            LineSeries<SalesData, String>(
                                dataSource: [
                                    SalesData('Jan', 35, segmentColor:  Colors.red),
                                    SalesData('Feb', 28,segmentColor: Colors.green),
                                    SalesData('Mar', 34, segmentColor:Colors.blue),
                                    SalesData('Apr', 32,segmentColor: Colors.pink),
                                    SalesData('May', 40,segmentColor: Colors.black),
                                    SalesData('Juin', 35, segmentColor:  Colors.red),
                                    SalesData('Juill', 28,segmentColor: Colors.green),
                                    SalesData('Aout', 34, segmentColor:Colors.blue),
                                    SalesData('Sept', 32,segmentColor: Colors.pink),
                                    SalesData('Oct', 40,segmentColor: Colors.black),
                                    SalesData('Nov', 32,segmentColor: Colors.pink),
                                    SalesData('Dec', 40,segmentColor: Colors.black)
                                ],
                                // Bind the color for all the data points from the data source
                                pointColorMapper:(SalesData sales, _) => sales.segmentColor,
                                xValueMapper: (SalesData sales, _) => sales.year,
                                yValueMapper: (SalesData sales, _) => sales.sales
                            ),
                             
                        ]
            )
                ), flex:3),
                  Expanded( child :SizedBox(width: double.infinity,child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                         title: ChartTitle(text: 'Analyse Annuelle Des Achats en DT',textStyle: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold,fontFamily:'Barlow')), //Chart title.
                        series: <ChartSeries>[
                            LineSeries<SalesData, String>(
                                dataSource: [
                               SalesData('Jan', 35, segmentColor:  Colors.red),
                                    SalesData('Feb', 28,segmentColor: Colors.green),
                                    SalesData('Mar', 34, segmentColor:Colors.blue),
                                    SalesData('Apr', 32,segmentColor: Colors.pink),
                                    SalesData('May', 40,segmentColor: Colors.black),
                                    SalesData('Juin', 35, segmentColor:  Colors.red),
                                    SalesData('Juill', 28,segmentColor: Colors.green),
                                    SalesData('Aout', 34, segmentColor:Colors.blue),
                                    SalesData('Sept', 32,segmentColor: Colors.pink),
                                    SalesData('Oct', 40,segmentColor: Colors.black),
                                    SalesData('Nov', 32,segmentColor: Colors.pink),
                                    SalesData('Dec', 40,segmentColor: Colors.black)
                                ],
                                // Bind the color for all the data points from the data source
                                pointColorMapper:(SalesData sales, _) => sales.segmentColor,
                                xValueMapper: (SalesData sales, _) => sales.year,
                                yValueMapper: (SalesData sales, _) => sales.sales
                            ),
                             
                        ]
            )
                ), flex:3),
                  Expanded( child :SizedBox(width: double.infinity,child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        title: ChartTitle(text: 'Analyse Annuelle Des Ventes en DT',textStyle: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold,fontFamily:'Barlow')), //Chart title.
                        series: <ChartSeries>[
                            LineSeries<SalesData, String>(
                                dataSource: [
                                    SalesData('Jan', 35, segmentColor:  Colors.red),
                                    SalesData('Feb', 28,segmentColor: Colors.green),
                                    SalesData('Mar', 34, segmentColor:Colors.blue),
                                    SalesData('Apr', 32,segmentColor: Colors.pink),
                                    SalesData('May', 40,segmentColor: Colors.black),
                                    SalesData('Juin', 35, segmentColor:  Colors.red),
                                    SalesData('Juill', 28,segmentColor: Colors.green),
                                    SalesData('Aout', 34, segmentColor:Colors.blue),
                                    SalesData('Sept', 32,segmentColor: Colors.pink),
                                    SalesData('Oct', 40,segmentColor: Colors.black),
                                    SalesData('Nov', 32,segmentColor: Colors.pink),
                                    SalesData('Dec', 40,segmentColor: Colors.black)
                                ],
                                // Bind the color for all the data points from the data source
                                pointColorMapper:(SalesData sales, _) => sales.segmentColor,
                                xValueMapper: (SalesData sales, _) => sales.year,
                                yValueMapper: (SalesData sales, _) => sales.sales
                            ),
                             
                        ]
            )
                ), flex:3)
                ],
              ) );
    
    
  }
    
  }
class ChartData {
        ChartData(this.x, this.y, [this.color]);
        final String x;
        final double y;
        final Color color;
    }