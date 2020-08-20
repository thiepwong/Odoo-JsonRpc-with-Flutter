import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odoo_client/app/data/pojo/menus.dart';
import "package:tree_view/tree_view.dart";

class ModulePage extends StatefulWidget {
  final List<MainMenu> menu;
  final data;

  ModulePage({this.menu, this.data});

  @override
  _ModulePageState createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<MainMenu> _menu;
  MainMenu _data;

  @override
  void initState() {
    super.initState();
    this._data = widget.data;
    this._menu = widget.menu;
  }


  static void _showDialog(context, m) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text(m.action),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

 
  @override
  Widget build(BuildContext context) {
    Row toolbar = new Row(
    
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[  
        // ListTile()
        IconButton(
          alignment: Alignment.centerLeft,
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        IconButton(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.zero,
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
          icon: Icon(Icons.menu, color: Colors.white),
        ),

        Align(
          alignment: Alignment.centerRight,
          child: Text(
            _data.name,
            textAlign: TextAlign.right,
          ),
        )
        // Your widgets here
      ],
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: toolbar,
      ),
      drawer: Drawer( 

        child: SafeArea(
          // margin: EdgeInsets.only(top:10.0),
          child:Column(
            children: [
              Expanded(child: Center(child: Text(_data.name,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),)), flex: 1, ) ,
              Expanded(child: _menuTreeView(_menu,context), flex:9)
            ],
          )  ,)
      ),
      body: Container(
        child: Center(
          child: Text(_data.name),
        ),
      ),
    );
  }

  var _menuTreeView = (_menu,context) =>TreeView(
      parentList: [
            for (var m1 in _menu)  Parent(
                parent: Container(  
                  decoration: BoxDecoration(
                    border: Border( 
                      bottom: BorderSide(width: 0.65, color: Colors.black38),
                    )  
                    ),
                  padding: const EdgeInsets.only(left:10.0), 
                  height: 30.0,
                  child: Row( 
                      textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.center, 
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children:[ 
                        Expanded(child: Align(alignment: Alignment.centerLeft, child:  m1.children.length >0?Text(m1.name):
                        TextButton(
                          onPressed: ()=> _showDialog(context,m1) , 
                        child: Text(m1.name), 
                        
                        ) ), flex:9 ),
                        m1.children.length >0? Expanded(child: Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_drop_down, color: Colors.blueGrey, size: 18)), flex:1):Container()
                  ])), 
                  childList: m1.children !=null?ChildList(
                    children:[
                      for (var m2 in m1.children)  m2.action!=null? Container(  
                                        decoration: BoxDecoration(
                                          border: Border( 
                                            bottom: BorderSide(width: 0.65, color: Colors.grey),
                                          )  
                                          ),
                                        padding: const EdgeInsets.only(left:30.0), 
                                        height: 30.0,
                                        child: Row( 
                                            textBaseline: TextBaseline.alphabetic,
                                          mainAxisAlignment: MainAxisAlignment.center, 
                                          crossAxisAlignment:CrossAxisAlignment.center,
                                          children:[ 
                                              Expanded(child: Align(alignment: Alignment.centerLeft, child:   TextButton(
                                                onPressed: ()=> _showDialog(context,m2) , 
                                              child: Text(m2.name), 
                                              
                                              )), flex:10 ),
                                              // Expanded(child: Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_drop_down, color: Colors.blueGrey, size: 18)), flex:1)
                                        ])):
                                        Parent(
                        parent:  Container(  
                                        decoration: BoxDecoration(
                                          border: Border( 
                                            bottom: BorderSide(width: 0.65, color: Colors.grey),
                                          )  
                                          ),
                                        padding: const EdgeInsets.only(left:30.0), 
                                        height: 30.0,
                                        child: Row( 
                                            textBaseline: TextBaseline.alphabetic,
                                          mainAxisAlignment: MainAxisAlignment.center, 
                                          crossAxisAlignment:CrossAxisAlignment.center,
                                          children:[ 
                                              Expanded(child: Align(alignment: Alignment.centerLeft, child: Text(m2.name)), flex:9 ),
                                              Expanded(child: Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_drop_down, color: Colors.blueGrey, size: 18)), flex:1)
                                        ])),
                        childList: ChildList(
                          children:[
                            for (var m3 in m2.children) m3.action!=null? 
                                 Container(  
                                        decoration: BoxDecoration(
                                          border: Border( 
                                            bottom: BorderSide(width: 0.35, color: Colors.grey),
                                          )  
                                          ),
                                        padding: const EdgeInsets.only(left:50.0), 
                                        height: 30.0,
                                        child: Row( 
                                            textBaseline: TextBaseline.alphabetic,
                                          mainAxisAlignment: MainAxisAlignment.center, 
                                          crossAxisAlignment:CrossAxisAlignment.center,
                                          children:[ 
                                              Expanded(child: Align(alignment: Alignment.centerLeft, child:   TextButton(
                                                onPressed: ()=> _showDialog(context,m3) , 
                                              child: Text(m3.name), 
                                              
                                              )), flex:10 ),

                                              // Expanded(child: Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_drop_down, color: Colors.blueGrey, size: 18)), flex:1)
                                        ])):
                                        Parent(
                              parent:  Container(  
                                        decoration: BoxDecoration(
                                          border: Border( 
                                            bottom: BorderSide(width: 0.35, color: Colors.grey),
                                          )  
                                          ),
                                        padding: const EdgeInsets.only(left:50.0), 
                                        height: 30.0,
                                        child: Row( 
                                            textBaseline: TextBaseline.alphabetic,
                                          mainAxisAlignment: MainAxisAlignment.center, 
                                          crossAxisAlignment:CrossAxisAlignment.center,
                                          children:[ 
                                              Expanded(child: Align(alignment: Alignment.centerLeft, child: Text(m3.name)), flex:9 ),
                                              Expanded(child: Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_drop_down, color: Colors.blueGrey, size: 18)), flex:1)
                                        ])),
                              childList: ChildList(children: [],),
                            )
                          ]
                        )
                      )
                    ]
                  ): null  
              )  
            ],
          ); 
  

}
