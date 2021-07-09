import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:responsive_table/responsive_table.dart';
import'package:gestion_commercial/Models/Authentification/Entreprise.dart';

class FirmTable extends StatefulWidget {
  @override
  _FirmTableState createState() => _FirmTableState();
}

class _FirmTableState extends State<FirmTable> {
  





  Entreprise entreprise= new Entreprise(null, null, null, null, null, null, null, null);
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
QueryResult firmsdata;
  _initData() async {
    var x =await entreprise.getEntreprises();
    print(x.data['getEntreprises'].length);
    setState(() {
      firmsdata=x;
      
       count=firmsdata.data['getEntreprises'].length;
    });
    
    setState(() => _isLoading = true);
    Future.delayed(Duration(seconds: 3)).then((value) {
      _source.addAll(_generateData(n:count));
      setState(() => _isLoading = false);
    });
  }
 
List<Map<String, dynamic>> temps;
  List<Map<String, dynamic>> _generateData({int n:100}) {
    final List source = List.filled(20, firmsdata.data['getEntreprises']);
    
     temps = List<Map<String, dynamic>>();
    var i = _source.length;
    print(i);
    for (var data in source) {
      temps.add({
     "Nom Legal":data[i]['NomLegal'],
        "Type De Commerce":data[i]['TypeDeCommerce'],
     "Téléphone": data[i]['Phone'],
        "Modules": [i,data[i]['module']],
        "Email":data[i]['Email'],
        "Fax":data[i]['Fax'],
        "Adresse":data[i]['Adresse'],
        
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
        text: "Nom Legal",
        value: "Nom Legal",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Type De Commerce",
        value: "Type De Commerce",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
   
    DatatableHeader(
        text: "Modules",
        value: "Modules",
        show: true,
        sortable: true,
        sourceBuilder: (value, row) {
         List v= value[1];
         List modules=[];
         for(int i=0;i<v.length;i++){
           modules.add(v[i]['libelle']);
           //print(modules[i]);
         }
        print(modules.toString());
         
          return Container(
            child: Column(
              children: [
                Container(
                  
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(modules.toString(),),
                    ],
                  )

                
                )],
            ),
          );
        },
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Téléphone",
        value: "Téléphone",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    
    DatatableHeader(
        text: "Email",
        value: "Email",
        show: true,
        sortable: false,
        textAlign: TextAlign.left),
        DatatableHeader(
        text: "Fax",
        value: "Fax",
        show: true,
        sortable: false,
        textAlign: TextAlign.left),
        DatatableHeader(
        text: "Adresse",
        value: "Adresse",
        show: true,
        sortable: false,
        textAlign: TextAlign.left),
        ];
    
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, title:Text('Tableau d\'Entreprises',style:TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,fontFamily:'Barlow')),elevation: 0.0,iconTheme: IconThemeData(color:Colors.black) ,),
      
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
                                icon: Icon(Icons.search), onPressed: () async{
                                  List<Map<String, dynamic>> recherche=List<Map<String, dynamic>>();
                                  var x= await entreprise.getEntreprise(recherchecon.text);
                                  print(x);
                                  setState(() {
                                   
                                            
                                           
                                                                       
                                    for(int i=0;i<x.data['getEntreprise'].length;i++){
                                    
                                  
                                     
                                       recherche.add({
       "Nom Legal":x.data['getEntreprise'][i]['NomLegal'],
        "Type De Commerce":x.data['getEntreprise'][i]['TypeDeCommerce'],
     "Téléphone": x.data['getEntreprise'][i]['Phone'],
        "Modules": [i,x.data['getEntreprise'][i]['module']],
        
        "Fax":x.data['getEntreprise'][i]['Fax'],
        "Adresse":x.data['getEntreprise'][i]['Adresse'],
        
                                       });}
                                     
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