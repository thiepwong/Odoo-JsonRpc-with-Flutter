

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; 
import '../../data/pojo/menus.dart'; 

class AppModule extends StatefulWidget {
  final List<MainMenu> menu;
  final data;

  AppModule({
    this.menu,this.data
  });

  @override
  _AppModuleState createState() =>  _AppModuleState();

}

class _AppModuleState extends State<AppModule>{
    List<MainMenu> _menu;
    MainMenu _data; 
    int initPosition = 1;
double a ;
  @override
  void initState() {
    super.initState();
    _menu = widget.menu;  
    _data = widget.data;
   
  
  }
  @override
  Widget build(BuildContext context) {
     
 a =   MediaQuery.of(context).size.width;
   print(a);
     return Scaffold(
       appBar: AppBar(
         title: Text(_data.name),
       ),
       body:  SafeArea(
          child: PageTabView(
            initPosition: initPosition,
            itemCount: _menu.length,
            tabBuilder: (context, index) => Tab(child: Align(widthFactor: MediaQuery.of(context).size.width*0.4/100, alignment: Alignment.center,child: Text( _menu[index].name) ,)),
            pageBuilder: (context, index) => Center(child: Column(children: [Text(_menu[index].name),  _menu[index].action!=null?Text(_menu[index].action ):Text('-'),
            Column(children: [
              for (var i in _menu[index].children) Text(i.name)
            ],) 
            ])),
            onPositionChange: (index){
              print('current position: $index');
              initPosition = index;
            },
            onScroll: (position) => print('$position'),
          ),
        ), 
       
      //  ListView.separated (
      //    separatorBuilder: (context, index) => Divider(
      //   color: Colors.grey,
      //   ),
      //    itemCount: _menu.length,
      //    itemBuilder: (context, index) => Container(
      //      child: ListTile( 
      //        title:  Text(_menu[index].name), 
      //        subtitle: _menu[index].action != null? Text(_menu[index].action): Column(
      //          children: [
      //            for (var m in _menu[index].children) 
      //                   Row(
      //                     children: [
      //                       Text( m.name),
      //                       Text(m.id.toString())
      //                   ] )
      //          ],
      //        ),
      //      ) 
      //    ),
      //   //  children: [
      //   //    for (var i in widget.menu) Text(i.name)
      //   //  ],
      //  ),
     );
  }


}


class PageTabView extends StatefulWidget {
    final int itemCount;
    final IndexedWidgetBuilder tabBuilder;
    final IndexedWidgetBuilder pageBuilder;
    final Widget stub;
    final ValueChanged<int> onPositionChange;
    final ValueChanged<double> onScroll;
    final int initPosition;

    PageTabView({
      @required this.itemCount,
      @required this.tabBuilder,
      @required this.pageBuilder,
      this.stub,
      this.onPositionChange,
      this.onScroll,
      this.initPosition,
    });

    @override
    _PageTabsState createState() => _PageTabsState();
  }

  class _PageTabsState extends State<PageTabView> with TickerProviderStateMixin {
    TabController controller;
    int _currentCount;
    int _currentPosition;

    @override
    void initState() {
      _currentPosition = widget.initPosition ?? 0;
      controller = TabController(
        length: widget.itemCount,
        vsync: this,
        initialIndex: _currentPosition,
      );
      controller.addListener(onPositionChange);
      controller.animation.addListener(onScroll);
      _currentCount = widget.itemCount;
      super.initState();
    }

    @override
    void didUpdateWidget(PageTabView oldWidget) {
      if (_currentCount != widget.itemCount) {
        controller.animation.removeListener(onScroll);
        controller.removeListener(onPositionChange);
        controller.dispose();

        if (widget.initPosition != null) {
          _currentPosition = widget.initPosition;
        }

        if (_currentPosition > widget.itemCount - 1) {
            _currentPosition = widget.itemCount - 1;
            _currentPosition = _currentPosition < 0 ? 0 : 
            _currentPosition;
            if (widget.onPositionChange is ValueChanged<int>) {
               WidgetsBinding.instance.addPostFrameCallback((_){
                if(mounted) {
                  widget.onPositionChange(_currentPosition);
                }
               });
            }
         }

        _currentCount = widget.itemCount;
        setState(() {
          controller = TabController(
            length: widget.itemCount,
            vsync: this,
            initialIndex: _currentPosition,
          );
          controller.addListener(onPositionChange);
          controller.animation.addListener(onScroll);
        });
      } else if (widget.initPosition != null) {
        controller.animateTo(widget.initPosition);
      }

      super.didUpdateWidget(oldWidget);
    }

    @override
    void dispose() {
      controller.animation.removeListener(onScroll);
      controller.removeListener(onPositionChange);
      controller.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      if (widget.itemCount < 1) return widget.stub ?? Container();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container( 
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topLeft,
            color: Colors.red[50],
            child: TabBar(
              
              isScrollable: true,
              controller: controller,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(context).hintColor,
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).accentColor,
                    width: 2,
                  ),
                ),
              ),
              tabs: List.generate(

                widget.itemCount,
                    (index) => widget.tabBuilder(context, index),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: List.generate(
                widget.itemCount,
                    (index) => widget.pageBuilder(context, index),
              ),
            ),
          ),
        ],
      );
    }

    onPositionChange() {
      if (!controller.indexIsChanging) {
        _currentPosition = controller.index;
        if (widget.onPositionChange is ValueChanged<int>) {
          widget.onPositionChange(_currentPosition);
        }
      }
    }

    onScroll() {
      if (widget.onScroll is ValueChanged<double>) {
        widget.onScroll(controller.animation.value);
      }
    }
  }