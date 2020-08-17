import 'package:flutter/material.dart';

class MainMenu {
    BigInt id;
    String name;
    int sequence;
    List<Map<Key,dynamic>> parentId;
    String action;
    String webIcon;
    String webIconData;
    List<MainMenu> children;
    String xmlId;

    MainMenu({ 
        this.id,this.name,this.action,this.children,this.parentId,this.sequence,this.webIconData,this.webIcon,this.xmlId
    });

 
}