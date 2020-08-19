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

  @override
  Widget build(BuildContext context) {
    Row toolbar = new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
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
      //   child: ListView.builder(
      //   itemCount: _menu.length,
      //   physics: const AlwaysScrollableScrollPhysics(),
      //   itemBuilder: (context, i) => InkWell(
      //     onTap: () {
      //       // push(PartnerDetails(data: _mainMenus[i]));
      //     },
      //     child: Column(
      //       children: <Widget>[
      //         Divider(
      //           height: 10.0,
      //         ),
      //         ListTile(
      //           leading: CircleAvatar(
      //             foregroundColor: Theme.of(context).primaryColor,
      //             backgroundColor: Colors.grey,
      //             // backgroundImage: NetworkImage(_mainMenus[i].name),
      //           ),
      //           title: Row(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: <Widget>[
      //               Text(
      //                 _menu[i].name,
      //                 style: TextStyle(fontWeight: FontWeight.bold),
      //               ),
      //             ],
      //           ),
      //           subtitle: Container(
      //               padding: const EdgeInsets.only(top: 5.0),
      //               child: Column(
      //                 children: [
      //                   for (var _m in _menu[i].children) Text(_m.name)
      //                 ],
      //               )),
      //         )
      //       ],
      //     ),
      //   ),
      // )),
      child: TreeView(
      parentList: [
            for (var m1 in _menu)  Parent(
                parent: ListTile(   title: Text(m1.name)), 
                childList: ChildList(
                  children:[
                    for (var m2 in m1.children)  m2.action!=null? ListTile( title: Padding(padding: EdgeInsets.only(left:30), child: Text(m2.name) ) ):Parent(
                      parent:ListTile( title: Padding(padding: EdgeInsets.only(left:30), child: Text(m2.name) ) ),
                      childList: ChildList(
                        children:[
                          for (var m3 in m2.children) m3.action!=null? ListTile( title: Padding(padding: EdgeInsets.only(left:60), child: Text(m3.name) ) ):Parent(
                            parent: ListTile( title: Padding(padding: EdgeInsets.only(left:60), child: Text(m3.name) ) ),
                            childList: ChildList(children: [],),
                          )
                        ]
                      )
                    )
                  ]
                )  
                )  
            ],
          )
      ),
      body: Container(
        child: Center(
          child: Text(_data.name),
        ),
      ),
    );
  }

  // var _menuTreeView = (menu)=>  
  //  TreeView(
  //   parentList: [
  //   for (var m1 in menu) Container(child: Parent(
  //       parent: Text(m1.name), 
  //       childList: ChildList(
  //         children:[
  //           for (var m2 in m1.children)  m2.action!=null?Text(m2.name):Parent(
  //             parent: Text(m2.name),
  //             childList: ChildList(
  //               children:[
  //                 for (var m3 in m2.children) m3.action!=null?Text(m3.name):Parent(
  //                   parent: Text(m3.name)
  //                 )
  //               ]
  //             )
  //           )
  //         ]
  //       ) 


  //       ) 
  //   )
  //   ],
  // );
  

}
