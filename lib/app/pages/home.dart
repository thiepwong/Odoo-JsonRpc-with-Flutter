import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:odoo_client/app/data/pojo/menus.dart';
import 'package:odoo_client/app/data/pojo/partners.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';
import 'package:odoo_client/app/data/services/odoo_response.dart';
import 'package:odoo_client/app/pages/partner_details.dart';
import 'package:odoo_client/app/utility/strings.dart';
import 'package:odoo_client/base.dart';

import 'profile.dart';
import 'settings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends Base<Home> {
  List<Partner> _partners = [];
  List<MainMenu> _mainMenus = [];

  _getMenus() async {
    isConnected().then((isInternet) {
      if (isInternet) {
        showLoading();
        odoo.loadMenus().then((OdooResponse res) {
          if (!res.hasError()) {
            setState(() {
              hideLoading();
              String session = getSession();
              session = session.split(",")[0].split(";")[0];
              for (var i in res.getMenuItems()) {
                _mainMenus.add(
                  new MainMenu(
                    id: BigInt.from(i["id"]),
                    name: i['name'],
                    action: i["action"] == false ? null : i["action"],
                    // children: List.of(i['children']) ,
                    parentId: i['parent_id'] == false ? null : i['parent_id'],
                    sequence: i['sequence'],
                    webIconData: i['web_icon_data'],
                    webIcon: i['web_icon'],
                    xmlId: i['xmlid'],
                  ),
                );
              }
            });
          } else {
            print(res.getError());
            showMessage("Warning", res.getErrorMessage());
          }
        }, onError: (err) {
          print(err.partialResult);
        });
      }
    });
  }

  _getPartners() async {
    isConnected().then((isInternet) {
      if (isInternet) {
        showLoading();
        odoo.searchRead(
            Strings.res_partner, [], ['email', 'name', 'phone']).then(
          (OdooResponse res) {
            if (!res.hasError()) {
              setState(() {
                hideLoading();
                String session = getSession();
                session = session.split(",")[0].split(";")[0];
                for (var i in res.getRecords()) {
                  _partners.add(
                    new Partner(
                      id: i["id"],
                      email: i["email"] is! bool ? i["email"] : "N/A",
                      name: i["name"],
                      phone: i["phone"] is! bool ? i["phone"] : "N/A",
                      imageUrl: getURL() +
                          "/web/image?model=res.partner&field=image&" +
                          session +
                          "&id=" +
                          i["id"].toString(),
                    ),
                  );
                }
              });
            } else {
              print(res.getError());
              showMessage("Warning", res.getErrorMessage());
            }
          },
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getOdooInstance().then((odoo) {
      // _getPartners();
      _getMenus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final emptyView = Container(
      alignment: Alignment.center,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.person_outline,
              color: Colors.grey.shade300,
              size: 100,
            ),
            Padding(
              padding: EdgeInsets.all(1.0),
              child: Text(
                Strings.no_orders,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Wechange Building manager"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              push(Settings());
            },
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              push(ProfilePage());
            },
          ),
        ],
      ),
      body: _mainMenus.length > 0
          ? GridView.builder(
              itemCount: _mainMenus.length,
              padding: EdgeInsets.all(20),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return new InkWell( 
                  customBorder: CircleBorder(),
                  onTap: (){
                      new  AlertDialog(content: Text('Khong biet duoc'));
                        print('da ok');
                    },
                  child:new Card(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    borderOnForeground: false,
                   margin: EdgeInsets.all(15), 
                    child: Stack( 
                      children: [
                       Center(
                         child:Image.memory(base64.decode(_mainMenus[index].webIconData.split(',').last), 
                         height:65,
                        )
                       ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Center(child:new Text( _mainMenus[index].name)) ,) 
                        
                      ],
                    ),
                  //   child: new GridTile( 
                  //   footer:  new GridTileBar(
                  //         title: new Text('the footer appears on the bottom of the tile')
                  //       ),

                  //   child: Image.memory(base64
                  //       .decode(_mainMenus[index].webIconData.split(',').last)),
                  // ),
                  )
                 
                );
              },
            )
          :
 

          // ListView.builder(
          //   itemCount: _mainMenus.length,
          //   physics: const AlwaysScrollableScrollPhysics(),
          //     itemBuilder: (context, i) => InkWell(
          //       onTap: () {
          //         // push(PartnerDetails(data: _mainMenus[i]));
          //       },
          //       child: Column(
          //         children: < Widget > [
          //           Divider(
          //             height: 10.0,
          //           ),
          //           ListTile(
          //             leading: CircleAvatar(
          //               foregroundColor: Theme.of(context).primaryColor,
          //               backgroundColor: Colors.grey,
          //               // backgroundImage: NetworkImage(_mainMenus[i].name),
          //             ),
          //             title: Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: < Widget > [
          //                 Text(
          //                   _mainMenus[i].name,
          //                   style: TextStyle(fontWeight: FontWeight.bold),
          //                 ),
          //               ],
          //             ),
          //             subtitle: Container(
          //               padding: const EdgeInsets.only(top: 5.0),
          //                 child: Text(
          //                   // _mainMenus[i].id.toString(),
          //                    _mainMenus[i].name,
          //                   style: TextStyle(color: Colors.grey, fontSize: 15.0),
          //                 ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          // ) :

          emptyView,
    );
  }
}
