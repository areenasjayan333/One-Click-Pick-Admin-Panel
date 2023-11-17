import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:shopping_admin/Utilities/enum_helper.dart';

class Vendor {
  String? id;
  String name;
  String shopName;
  String address;
  String phoneNo;
  String pinNo;
  String licenseNo;

  bool? isActive;
  bool? isOpen;

  Vendor({
    this.id,
    required this.name,
    required this.shopName,
    required this.phoneNo,
    required this.address,
    required this.licenseNo,
    required this.pinNo,
    this.isActive,
    this.isOpen,
  });
}

class VendorProvider with ChangeNotifier {
  final _cloud = FirebaseFirestore.instance;

  List<Vendor> _vendorRequests = [];

  List<Vendor> get vendorRequests {
    return _vendorRequests;
  }

  Future<ProviderResponse> getBecomeVendorRequests() async {
    try {
      List<Vendor> vendorRequestList = [];

      final becomeVendorResponse =
          await _cloud.collection('becomeAVendorRequest').get();

      for (var element in becomeVendorResponse.docs) {
        final data = element.data();

        print('data= $data');

        vendorRequestList.add(Vendor(
          id: element.id,
          name: data["name"],
          shopName: data["shopName"],
          address: data["address"],
          phoneNo: data["phoneNo"],
          pinNo: data["pinNo"],
          licenseNo: data["licenseNo"],
          isActive: false,
          isOpen: false,
        ));
      }
      _vendorRequests = vendorRequestList;

      notifyListeners();
      return ProviderResponse.success;
    } catch (e) {
      return ProviderResponse.error;
    }
  }
}
