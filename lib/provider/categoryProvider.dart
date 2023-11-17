import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../Utilities/enum_helper.dart';

class ShopCategory {
  String? id;
  String categoryName;
  String? fileName;
  String imageID;
  String imageUrl;
  dynamic image;

  ShopCategory({
    this.id,
    required this.categoryName,
    this.fileName,
    required this.imageID,
    required this.imageUrl,
    this.image,
  });
}

class CategoryProvider with ChangeNotifier {
  final _cloud = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  List<ShopCategory> _categories = [];

  List<ShopCategory> get categories {
    return _categories;
  }

  Future<ProviderResponse> addCategory(ShopCategory category) async {
    try {
      final imageUpload = await _storage
          .ref()
          .child('category')
          .child(category.fileName!)
          .putData(category.image, SettableMetadata(contentType: 'image/jpeg'));

      final downloadUrl = await imageUpload.ref.getDownloadURL();

      final data = {
        "imageID": imageUpload.ref.fullPath,
        "imageURL": downloadUrl,
        "categoryName": category.categoryName,
      };

      final result = await _cloud.collection('category').add(data);
      category.id = result.id;
      category.imageID = imageUpload.ref.fullPath;
      category.imageUrl = downloadUrl;

      print(downloadUrl);

      _categories.add(category);

      notifyListeners();
      return ProviderResponse.success;
    } catch (e) {
      return ProviderResponse.error;
    }
  }

  Future<ProviderResponse> getCategories() async {
    try {
      print('get started');
      List<ShopCategory> categoryItems = [];

      final response = await _cloud.collection('category').get();

      for (var element in response.docs) {
        final data = element.data();

        print('data= $data');

        categoryItems.add(ShopCategory(
          id: element.id,
          categoryName: data["categoryName"],
          imageID: data["imageID"],
          imageUrl: data["imageURL"],
        ));
      }
      print('complete');
      _categories = categoryItems;
      print('cat= $_categories');

      notifyListeners();
      return ProviderResponse.success;
    } catch (e) {
      return ProviderResponse.error;
    }
  }

  Future<ProviderResponse> deleteCategory({String? imageID, String? id}) async {
    try {
      if (imageID != "") {
        _storage.ref().child(imageID!).delete();
      }
      await _cloud.collection('category').doc(id).delete();
      _categories.removeWhere((element) => element.id == id);

      notifyListeners();
      return ProviderResponse.success;
    } catch (e) {
      return ProviderResponse.error;
    }
  }
}
