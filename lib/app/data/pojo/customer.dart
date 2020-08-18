import 'package:flutter/material.dart';
 
class Customer {
  int id;
  String displayName;
  String phone;
  String email;
  List<Map<Key, String>> companyId;
  int resident;
  Map<Key, String> ward;
  Map<Key, String> district;
  Map<Key, String> province;
  bool active;
  String taxCode;
  int userId;
  bool isCompany;
  int parentId;

  Customer(
      {this.active,
      this.companyId,
      this.displayName,
      this.district,
      this.email,
      this.id,
      this.isCompany,
      this.parentId,
      this.phone,
      this.province,
      this.resident,
      this.taxCode,
      this.userId,
      this.ward});
}
