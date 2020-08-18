import 'package:flutter/material.dart';

class MainMenu {
    BigInt id;
    String name;
    int sequence;
    List<Map<String,MainMenu>> parentId;
    String action;
    String webIcon;
    String webIconData;
    // List<MainMenu> children;
    List<MainMenu> children;
    String xmlId;

    MainMenu({ 
        this.id,this.name,this.action,this.children,this.parentId,this.sequence,this.webIconData,this.webIcon,this.xmlId
    });

    // factory MainMenu.fromJson(Map<String,MainMenu>json) => MainMenu (
    //     children: List<MainMenu>.from(json['children']).map((e) => MainMenu.fromJson(e) )
    // );
    
    // {
      // List<dynamic> _children = json['children'];
      // List<MainMenu> children = _children.map((e) => MainMenu.fromJson(e)).toList();
      // id = json['id'];
      // name =json['name'];
      // sequence = json['sequence'];
      // action = json['action'];
      // children = children; 
    // }

 
}