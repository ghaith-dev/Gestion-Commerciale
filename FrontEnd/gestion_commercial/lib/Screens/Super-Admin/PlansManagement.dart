import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gestion_commercial/Responsive.dart';
import'./Style/TextStyle.dart';
import 'package:numberpicker/numberpicker.dart';
import'package:gestion_commercial/Models/Authentification/Plan.dart';

class PlansManagement extends StatefulWidget {
  @override
  _PlansManagementState createState() => _PlansManagementState();
}
Plan plan;
List<Plan> planList=[];
var plansResult;
 TextEditingController planTypeController = new TextEditingController();
 TextEditingController prixController = new TextEditingController();
 TextEditingController dureeTypeController = new TextEditingController();
 TextEditingController addplanTypeController = new TextEditingController();
 TextEditingController addprixController = new TextEditingController();
 TextEditingController adddureeTypeController = new TextEditingController();

class _PlansManagementState extends State<PlansManagement> {
  Future <void> _initData()async{
 Plan plan=new Plan(null, null, null, null);
  plansResult= await plan.getPalns();
 


  }
  @override
  void initState() {
   _initData();
   
    super.initState();
  }
  @override
  
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;

    var height=MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: _initData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
            if(snapshot.connectionState== ConnectionState.waiting){
              return Scaffold(body:Center(child: CircularProgressIndicator(),));
            }
          return Scaffold(
        
        appBar:  AppBar(backgroundColor: Colors.white, title:Text('Pack d\'abonnement',style:TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'Barlow')),elevation: 0.0,iconTheme: IconThemeData(color:Colors.black)),
        body:Stack(
         
          children: [
            ListView.separated(
              itemCount: plansResult.data['getPlans'].length,
            
               separatorBuilder:  (BuildContext context, int index) => Divider(),
               itemBuilder: (BuildContext context, int index) {
                   plan=new Plan(plansResult.data['getPlans'][index]['id'], plansResult.data['getPlans'][index]['planType'], double.parse(plansResult.data['getPlans'][index]['prix'].toString()), plansResult.data['getPlans'][index]['duree']);
                   planList.add(plan);
      return ListTile(
            title: Text('Libellé:'+' '+plan.planType,style: Textstyle(),),tileColor:Colors.white,
            subtitle: plan.prix!=0 ?Text('Prix:'+''+plan.prix.toString()+' ' ' DT\n Durée:' ' ${plan.duree}' ' Jours',style: TextStyle(fontSize: 18,fontFamily: 'Barlow',),)
            : Text('Prix:'+''+'Gratuit \n Durée:' ' ${plan.duree}' ' Jours',style: TextStyle(fontSize: 18,fontFamily: 'Barlow',),), 
            leading: InkWell(child: Icon(Icons.mode_rounded ,color: primaryColor,),onTap: ()=>{
              print(plan.planType),
              planTypeController.text=planList[index].planType,
              prixController.text=planList[index].prix.toString(),
              dureeTypeController.text=planList[index].duree.toString(),
              showDialog(context: context, builder: (context)=>_buildUpdateDialog(context,planList[index]))
              
            },),
            trailing: InkWell(child: (Icon(Icons.delete,color: primaryColor,)),onTap: (){
              showDialog(context: context, builder: (context)=>_buildDeletDialog(context,plan));
             


            },),
            
            );
                
       
            
            
            
      
  },
                ),
              
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(alignment: Alignment.bottomRight,child: FittedBox(fit:BoxFit.fill,child:kIsWeb ? 
                   Container(width: width*0.1,height: height*0.1,child: FloatingActionButton(backgroundColor: Colors.primaryColor,child: Icon(Icons.add,size: 30,),onPressed: (){showDialog(context: context, builder: (context)=>_buildAddDialog(context,));},))
                
                   :Container(width: width*0.19,height: height*0.15,child: FloatingActionButton(backgroundColor: Colors.primaryColor,child: Icon(Icons.add,size: 40,),onPressed: (){showDialog(context: context, builder: (context)=>_buildAddDialog(context,));},))),
                )
                )],
        ),

      );
          });
  }
  Widget _buildUpdateDialog(BuildContext context,Plan plan) {
     
  return new AlertDialog(
    title: const Text('Modifier Le Pack'),titleTextStyle: Textstyle(),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextBox(hintText:'Libellé',icons: Icons.text_fields_rounded,inputType: TextInputType.text,controller: planTypeController,color:Colors.primaryColor),
        TextBox(hintText:'Prix',icons:Icons.attach_money_rounded,inputType:TextInputType.number,controller: prixController,suffixText: 'DT',color:Colors.primaryColor),
        TextBox(hintText:'Dureé',icons:Icons.timer,inputType:TextInputType.number,controller: dureeTypeController,suffixText: 'Jours',color:Colors.primaryColor)
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () async{
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Fermer',style: TextStyle(color: Colors.primaryColor),),
        
      ),
       FlatButton(
        onPressed: () async{
          Plan updatedPlan = new Plan(plan.id,planTypeController.text,double.parse(prixController.text),int.parse(dureeTypeController.text));
          
          var result = await updatedPlan.updatePalns();
          await print(updatedPlan.id);
          dureeTypeController.clear();
          planTypeController.clear();
          prixController.clear();
          if(result.data['UpdatePlan']!=null)
          {Navigator.of(context).pop();
          }
          else
          print(result.data);
          
          
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Modifier Pack',style: TextStyle(color: Colors.primaryColor))),
    ],
  );
}
Widget _buildDeletDialog(BuildContext context,Plan plan) {
  return new AlertDialog(
    title: const Text('Supprimer  Pack'),titleTextStyle: Textstyle(),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Vous êtes sûr de supprimer ce pack ??',style: Textstyle(),),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Non',style: TextStyle(color: Colors.primaryColor),),
        
      ),
       FlatButton(
        onPressed: () async{
          var result=await plan.deletePalns();
          if(result.data['DeletePlan'])
          {
            setState(() {
              Navigator.of(context).pop();
            });
          
          }
          else
          print('Not ok');
          
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Oui',style: TextStyle(color: Colors.primaryColor))),
    ],
  );
}
Widget _buildAddDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('Ajouter Pack'),titleTextStyle: Textstyle(),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
                  child: Column(
            children: [
              TextBox(hintText:'Libellé',icons: Icons.text_fields_rounded,inputType: TextInputType.text,controller: addplanTypeController,color:Colors.primaryColor),
              TextBox(hintText:'Prix',icons:Icons.attach_money_rounded,inputType:TextInputType.number,controller: addprixController,suffixText: 'DT',color:Colors.primaryColor),
              TextBox(hintText:'Dureé',icons:Icons.timer,inputType:TextInputType.number,controller: adddureeTypeController,suffixText: 'Jours',color:Colors.primaryColor),
            ],
          ),
        )
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Fermer',style: TextStyle(color: Colors.primaryColor),),
        
      ),
       FlatButton(
        onPressed: () async{
          Plan newPlan= new Plan(null,addplanTypeController.text,double.parse(addprixController.text),int.parse(adddureeTypeController.text));
          var result=await newPlan.createPalns();
          if(result.data['CreatePlan']['id']!=null)
          {adddureeTypeController.clear();
          addplanTypeController.clear();
          addprixController.clear();
          Navigator.of(context).pop();}
          else
          print('not ok:'+result.data);
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Ajouter Pack',style: TextStyle(color: Colors.primaryColor))),
    ],
  );
}
}