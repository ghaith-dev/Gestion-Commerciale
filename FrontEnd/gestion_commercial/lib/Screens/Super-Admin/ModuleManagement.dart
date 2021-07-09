
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gestion_commercial/Models/Authentification/Module.dart';
import '../../Responsive.dart';
import'./Style/TextStyle.dart';

class ModuleManagement extends StatefulWidget {
  @override
  _ModuleManagementState createState() => _ModuleManagementState();
}

class _ModuleManagementState extends State<ModuleManagement> {
  Module module;
  
  
List<Module> moduleList=[];
Map<int,String> submoduleList={};
List getSubModuleListe=[];

var modulesResult;
 TextEditingController moduleLibController = new TextEditingController();
 TextEditingController prixController = new TextEditingController();
 TextEditingController dureeTypeController = new TextEditingController();
 TextEditingController addmoduleLibController = new TextEditingController();
 TextEditingController addprixController = new TextEditingController();
 TextEditingController adddureeTypeController = new TextEditingController();


  Future <void> _initData()async{
 Module module=new Module(null, null);
  modulesResult= await module.getModules();
  print(modulesResult);
 


  }
  @override
  void initState() {
   _initData();
   
    super.initState();
  }
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: _initData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
            if(snapshot.connectionState== ConnectionState.waiting){
              return Scaffold(body:Center(child: CircularProgressIndicator(),));
            }
          return Scaffold(
        
        appBar:Responsive.isDesktop(context)? null : AppBar(backgroundColor: Colors.white, title:Text(' Les Modules de Gestion',style:TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'Barlow')),elevation: 0.0,iconTheme: IconThemeData(color:Colors.black)),
        body:Responsive.isDesktop(context)==true? Row(children: [
        
        Expanded(flex: 2,child: 
        Container(
          child:Container(
          
          child:Image.asset('Assets/Images/Modules.jpg' ,height: MediaQuery.of(context).size.height,fit: BoxFit.fill,),
          color: Colors.primaryColor,)
          )
          ),
          Expanded(flex: 4,child: PlanManagmentForm(),
        
          ),
          
          
          
          ])

        
          :PlanManagmentForm()
      
      

      );
          });
  }
  Widget PlanManagmentForm(){
    var width=MediaQuery.of(context).size.width;

    var height=MediaQuery.of(context).size.height;
    return Stack(
         
          children: [
            ListView.separated(
              itemCount: modulesResult.data['getmoduls'].length,
            
               separatorBuilder:  (BuildContext context, int index) => Divider(),
               itemBuilder: (BuildContext context, int index) {
                   module=new Module(modulesResult.data['getmoduls'][index]['id'], modulesResult.data['getmoduls'][index]['libelle']);
                   moduleList.add(module);
                                   
      return ListTile(
            title: Text('Libellé:'+' '+module.libelle,style: Textstyle(),),tileColor:Colors.white,
           
            trailing: InkWell(child: Icon(Icons.mode_rounded ,color: primaryColor,),onTap: ()=>{
              print(index),
      moduleLibController.clear(),
             
              
              showDialog(context: context, builder: (context)=>_buildUpdateDialog(context,modulesResult.data['getmoduls'][index]['libelle'],modulesResult.data['getmoduls'][index]['SubModule']))
              
            },),
            
            
            );
                
       
            
            
            
      
  },
                ),
              
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(alignment: Alignment.bottomRight,child: FittedBox(fit:BoxFit.fill,child:kIsWeb ? 
                   Container(width: width*0.1,height: height*0.1,child: FloatingActionButton(backgroundColor: Colors.primaryColor,child: Icon(Icons.add,size: 30,),onPressed: (){showDialog(context: context, builder: (context)=>StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {  
                   return _buildAddDialog(context,);}));},))
                
                   :Container(width: width*0.19,height: height*0.15,child: FloatingActionButton(backgroundColor: Colors.primaryColor,child: Icon(Icons.add,size: 40,),onPressed: (){showDialog(context: context, builder: (context)=>_buildAddDialog(context,));},))),
                )
                )],
        );
  }
  Widget _buildUpdateDialog(BuildContext context,var module,var submodule) {
    print(submodule);
     converttomap(List list){
    Map<int,String> map={};
         for(int i=0;i<list.length;i++){
           map[i]=list[i];

         }
         return map;
         }
     
      List sub=submodule;
     Map<int,String>map=converttomap(sub);
     print(map);
     moduleLibController.text=module;
      var chvalue=submodule.length==1?true:false;
  var chvalue1=submodule.length>1?true:false;
  var chvalue2=submodule.length>2?true:false;
  var chvalue3=submodule.length>3?true:false;
  var chvalue4=submodule.length>4?true:false;
  var chvalue5=submodule.length>5?true:false;
  converttolist(Map<int,String>map){
    List<String> list=[];
         for(int i=0;i<map.length;i++){
           list.add('\"'+map[i]+"\"");

         }
         return list;
  }
  return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {  
      return new AlertDialog(
    title: const Text('Modifier Module'),titleTextStyle: Textstyle(),
    content: SingleChildScrollView(
        child: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextBox(hintText:'Libellé',icons: Icons.text_fields_rounded,inputType: TextInputType.text,controller:moduleLibController,color: Colors.primaryColor),
           CheckboxListTile(
             
        title: Text("Client"),
        value: chvalue,
        onChanged: (newValue) {
        setState(() {
          chvalue=newValue;
          if(newValue)
          map[0]= 'Client';
          else
          map.remove(0);
          print(map);
          
        });
        },
        
        
),

         CheckboxListTile(
        title: Text("Fournisseur"),
        value: chvalue1,
        onChanged: (newValue) {
        setState(() {
          chvalue1=newValue;
          if(newValue)
          map[1]='Fournisseur';
          else
          map.remove(1);

          print(map);
        });
        },),
        CheckboxListTile(
        title: Text("Stock"),
        value: chvalue2,
        onChanged: (newValue) {
        setState(() {
          chvalue2=newValue;
          if(newValue)
          map[2]= 'Stock';
          else
          map.remove(2);
          print(map);
        });
        },),
        CheckboxListTile(
        title: Text("Commande"),
        value: chvalue3,
        onChanged: (newValue) {
        setState(() {
          chvalue3=newValue;
          if(newValue)
          map[3]='Commande';
          else
          map.remove(3);
          
          print(map);
        });
        },),
        CheckboxListTile(
        title: Text("Facturation"),
        value: chvalue4,
        onChanged: (newValue) {
        setState(() {
          chvalue4=newValue;
          if(newValue)
          map[4]='Facturation';
          else
          
          map.remove(4);
          print(map);
        });
        },),
        CheckboxListTile(
        title: Text("Comptabilité"),
        value: chvalue5,
        onChanged: (newValue) {
        setState(() {
          chvalue5=newValue;
          if(newValue)
          map[5]='Comptabilité';
          else
          map.remove(5);
          print(map);
        });
        },),
        ],
      ),
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
          Module updatedModule = new Module(module.id,moduleLibController.text);
          
          var result = await updatedModule.updateModules();
          await print(updatedModule.id);
    
         moduleLibController.clear();
      
          if(result.data['UpdateModule']!=null)
          {Navigator.of(context).pop();
          }
          else
          print(result.data);
          
          
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Modifier Pack',style: TextStyle(color: Colors.primaryColor))),
    ],
      );
      });
}

Widget _buildAddDialog(BuildContext context) {
  var chvalue=false;
  var chvalue1=false;
  var chvalue2=false;
  var chvalue3=false;
  var chvalue4=false;
  var chvalue5=false;
  converttolist(Map<int,String>map){
    List<String> list=[];
         for(int i=0;i<map.length;i++){
           list.add('\"'+map[i]+"\"");

         }
         return list;
  }
  return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {  
      return new AlertDialog(
      title: const Text('Ajouter Module'),titleTextStyle: Textstyle(),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
              child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           
            TextBox(hintText:'Libellé',icons: Icons.text_fields_rounded,inputType: TextInputType.text,controller:addmoduleLibController,color: Colors.primaryColor),
          CheckboxListTile(
    title: Text("Client"),
    value: chvalue,
    onChanged: (newValue) {
        setState(() {
          chvalue=newValue;
          if(newValue)
          submoduleList[0]= 'Client';
          else
          submoduleList.remove(0);
          print(submoduleList);
          
        });
    },
    
    
),

         CheckboxListTile(
    title: Text("Fournisseur"),
    value: chvalue1,
    onChanged: (newValue) {
        setState(() {
          chvalue1=newValue;
          if(newValue)
          submoduleList[1]='Fournisseur';
          else
          submoduleList.remove(1);

          print(submoduleList);
        });
    },),
    CheckboxListTile(
    title: Text("Stock"),
    value: chvalue2,
    onChanged: (newValue) {
        setState(() {
          chvalue2=newValue;
          if(newValue)
          submoduleList[2]= 'Stock';
          else
          submoduleList.remove(2);
          print(submoduleList);
        });
    },),
    CheckboxListTile(
    title: Text("Commande"),
    value: chvalue3,
    onChanged: (newValue) {
        setState(() {
          chvalue3=newValue;
          if(newValue)
          submoduleList[3]='Commande';
          else
          submoduleList.remove(3);
          
          print(submoduleList);
        });
    },),
    CheckboxListTile(
    title: Text("Facturation"),
    value: chvalue4,
    onChanged: (newValue) {
        setState(() {
          chvalue4=newValue;
          if(newValue)
          submoduleList[4]='Facturation';
          else
          
          submoduleList.remove(4);
          print(submoduleList);
        });
    },),
    CheckboxListTile(
    title: Text("Comptabilité"),
    value: chvalue5,
    onChanged: (newValue) {
        setState(() {
          chvalue5=newValue;
          if(newValue)
          submoduleList[5]='Comptabilité';
          else
          submoduleList.remove(5);
          print(submoduleList);
        });
    },),
    
     ],
        ),
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
            Module newModule= new Module(null,addmoduleLibController.text,submoduleList: converttolist(submoduleList));
          
            var result=await newModule.createModules();
            print(result.data);
            if(result.data['CreatModule']['id']!=null)
            {
           addmoduleLibController.clear();
            submoduleList.clear();
            Navigator.of(context).pop();}
            else
            print('not ok:'+result.data);
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Ajouter Modules',style: TextStyle(color: Colors.primaryColor))),
      ],
    );
 });
}
}