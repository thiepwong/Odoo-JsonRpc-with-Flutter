

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../data/pojo/menus.dart';
import '../../data/pojo/menus.dart';

class CustomerList extends StatefulWidget {
  final List<MainMenu> menu;
  final data;

  CustomerList({
    this.menu,this.data
  });

  @override
  _CustomerListState createState() =>  _CustomerListState();

}

class _CustomerListState extends State<CustomerList>{
    List<MainMenu> _menu;

  @override
  void initState() {
    super.initState();
    _menu = widget.menu;  
  }
  @override
  Widget build(BuildContext context) {
     

     return Scaffold(
       appBar: AppBar(
         title: Text('Customer List'),
       ),
       body:  ListView.separated (
         separatorBuilder: (context, index) => Divider(
        color: Colors.grey,
        ),
         itemCount: _menu.length,
         itemBuilder: (context, index) => Container(
           child: ListTile( 
             title:  Text(_menu[index].name), 
             subtitle: _menu[index].action != null? Text(_menu[index].action): Column(
               children: [
                 for (var m in _menu[index].children) 
                        Row(
                          children: [
                            Text( m.name),
                            Text(m.id.toString())
                        ] )
               ],
             ),
           ) 
         ),
        //  children: [
        //    for (var i in widget.menu) Text(i.name)
        //  ],
       ),
     );
  }


}