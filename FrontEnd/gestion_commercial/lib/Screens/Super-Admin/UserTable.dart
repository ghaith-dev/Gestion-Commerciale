import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:responsive_table/responsive_table.dart';
import'package:gestion_commercial/Models/Authentification/User.dart';

class UserTable extends StatefulWidget {
 
  @override
  _UserTableState createState() => _UserTableState();
}



class _UserTableState extends State<UserTable> {
  User user= new User(null, null, null, null, null, null, null, null);
  bool switchvalue;
  
   TextEditingController recherchecon= new TextEditingController();
  

  List<int> _perPages = [5, 10, 15, 100];
  int _total = 100;
  int _currentPerPage;
  int _currentPage = 1;
  bool _isSearch = false;
  List<Map<String, dynamic>> _source = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> _selecteds = List<Map<String, dynamic>>();
  String _selectableKey = "id";

  String _sortColumn;
  bool _sortAscending = true;
  bool _isLoading = true;
  bool _showSelect = true;

var count;
QueryResult userdata;
  _initData() async {
    var x =await user.getUsers();
    
    setState(() {
      userdata=x;
      print(x);
       count=userdata.data['getUsers'].length;
    });
    
    setState(() => _isLoading = true);
    Future.delayed(Duration(seconds: 3)).then((value) {
      _source.addAll(_generateData(n: count));
      setState(() => _isLoading = false);
    });
  }
 
List<Map<String, dynamic>> temps;
  List<Map<String, dynamic>> _generateData({int n:100}) {
    final List source = List.filled(count, userdata.data['getUsers']);
    
     temps = List<Map<String, dynamic>>();
    var i = _source.length;
    print(i);
    for (var data in source) {
      setState(() {
        switchvalue=data[i]['Suspended'];
      
    });
      temps.add({
        "Nom":data[i]['Nom'],
        "Prénom":data[i]['Prenom'],
        "Email": data[i]['Email'],
        "Phone": data[i]['Phone'],
        "Role": data[i]['Role']['libelle'],
        "Entreprise":data[i]['IdEnt']['NomLegal'],
        "Etat": [i,data[i]['IsVerified']],
        "Suspendu":[i,data[i]['Suspended'],data[i]['id'],user],
        
      });
      i++;
    }
    return temps;
  }
  @override
  void initState() {
    super.initState();
    ;

    _initData();
  }

  @override
  void dispose() {
    super.dispose();
  }
   

  @override
   Widget build(BuildContext context) {
      List<DatatableHeader> _headers = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: false,
        sortable: true,
        textAlign: TextAlign.right),
    DatatableHeader(
        text: "Nom",
        value: "Nom",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Prénom",
        value: "Prénom",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Email",
        value: "Email",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Phone",
        value: "Phone",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Role",
        value: "Role",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Entreprise",
        value: "Entreprise",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    
    DatatableHeader(
        text: "Etat",
        value: "Etat",
        show: true,
        sortable: false,
        sourceBuilder: (value, row) {
         
          return Container(
            child: Column(
              children: [
                Container(
                  width: 85,
                  child:  value.last==true ?Text("Vérifié",style:TextStyle(color:Colors.green[600],fontWeight:FontWeight.bold))

                 :Text("Non Vérifié",style:TextStyle(color:Colors.red[600],fontWeight:FontWeight.bold))
                )],
            ),
          );
        },
        textAlign: TextAlign.center),
        DatatableHeader(
        text: "Suspendu",
        value: "Suspendu",
        show: true,
        sortable: false,
        sourceBuilder: (values, row) {
         
          return Container(
            child: Column(
              children: [
                Container(
                  width: 85,
                  child:  Switch(
                    activeColor: Colors.green,
                    dragStartBehavior: DragStartBehavior.start,
                    
                    inactiveTrackColor: Colors.red,
                    value: values[1],
                    onChanged:   (bool value)async{
                      
                      var stat;
                      if(values[1])
                      stat=1;
                      else
                      stat=0;
                    User user=values[3];
                    var x= await user.suspendUser(values[2], stat);
                    if(x.data['SuspendUser']){
                      setState(() {
                        if(stat==1){
                         values.insert(1, false);
                         
                          
                          
                        }else{values.insert(1, true);}
                      });
                    }
                    },
                    


                  )
                )],
            ),
          );
        },
        textAlign: TextAlign.center),
  
  ];
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, title:Text('Tableau d\'Utilisateurs',style:TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'Barlow')),elevation: 0.0,iconTheme: IconThemeData(color:Colors.black)),
      
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(0),
              constraints: BoxConstraints(
                maxHeight: 700,
              ),
              child: Card(
                elevation: 1,
                shadowColor: Colors.black,
                clipBehavior: Clip.none,
                child: ResponsiveDatatable(
                  
                  actions: [
                    if (_isSearch)
                      Expanded(
                          child: TextField(
                            controller:recherchecon,
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    _isSearch = false;
                                    _initData();
                                  });
                                }),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.search), onPressed: ()async {
                                  List<Map<String, dynamic>> recherche=List<Map<String, dynamic>>();
                                  var x=await user.getUser(recherchecon.text);
                                  
                                  setState(() {
                                    for(int i=0;i<x.data['getUser'].length;i++){
                                    
                                  
                                    
                                       recherche.add({
       "Nom":x.data['getUser'][i]['Nom'],
        "Prénom":x.data['getUser'][i]['Prenom'],
        "Email": x.data['getUser'][i]['Email'],
        "Phone": x.data['getUser'][i]['Phone'],
        "Role": x.data['getUser'][i]['Role'],
        "Entreprise": x.data['getUser'][i]["IdEnt"]["NomLegal"],
        "Etat": [i,x.data['getUser'][i]['IsVerified']],
        "Suspendu":[i,x.data['getUser'][i]['Suspended'],x.data['getUser'][i]['id'],user],
                                       });
                                     }
                                   _source= recherche;
                                    
                                 
                                  });
                                })
                                ),
                                onEditingComplete: (){

                                },
                      )),
                    if (!_isSearch)
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              _isSearch = true;
                            });
                          })
                  ],
                  headers: _headers,
                  source: _source,
                  selecteds: _selecteds,
                  showSelect: _showSelect,
                  autoHeight: false,
                  onTabRow: (data) {
                    print(data);
                  },
                  onSort: (value) {
                    setState(() {
                      _sortColumn = value;
                      _sortAscending = !_sortAscending;
                      if (_sortAscending) {
                        _source.sort((a, b) =>
                            b["$_sortColumn"].compareTo(a["$_sortColumn"]));
                      } else {
                        _source.sort((a, b) =>
                            a["$_sortColumn"].compareTo(b["$_sortColumn"]));
                      }
                    });
                  },
                  sortAscending: _sortAscending,
                  sortColumn: _sortColumn,
                  isLoading: _isLoading,
                 
                 
                  footers: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Lignes par page:"),
                    ),
                    if (_perPages != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: DropdownButton(
                            value: _currentPerPage,
                            items: _perPages.map((e) => DropdownMenuItem(
                                      child: Text("$e"),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _currentPerPage = value;
                              });
                            }),
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child:
                          Text("$_currentPage - $_currentPerPage of $_total"),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                      ),
                      onPressed: () {
                        setState(() {
                          _currentPage =
                              _currentPage >= 2 ? _currentPage - 1 : 1;
                        });
                      },
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: () {
                        setState(() {
                          _currentPage++;
                        });
                      },
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    )
                  ],
                ),
              ),
            ),
          ] 
        )
      ),
     
    );
  }
}