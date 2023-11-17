import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shopping_admin/Utilities/enum_helper.dart';

class OfferBanner {
  String? id;
  String fileName;
  String imageID;
  String imageUrl;
  dynamic image;

  OfferBanner({
    this.id,
    required this.fileName,
    required this.imageID,
    required this.imageUrl,
    this.image,
  });
}

class OfferBannerProvider with ChangeNotifier {
  final _cloud = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  List<OfferBanner> _offerBanners = [];

  List<OfferBanner> get offerBanners {
    return _offerBanners;
  }

  Future<ProviderResponse> addBanner(OfferBanner offerBanner) async {
    try {
      final imageUpload = await _storage
          .ref()
          .child('banner')
          .child(offerBanner.fileName)
          .putData(
              offerBanner.image, SettableMetadata(contentType: 'image/jpeg'));

      final downloadUrl = await imageUpload.ref.getDownloadURL();

      final data = {
        "imageID": imageUpload.ref.fullPath,
        "imageURL": downloadUrl,
        "fileName": offerBanner.fileName
      };

      final result = await _cloud.collection('banner').add(data);
      offerBanner.id = result.id;
      offerBanner.imageID = imageUpload.ref.fullPath;
      offerBanner.imageUrl = downloadUrl;

      print(downloadUrl);

      _offerBanners.add(offerBanner);

      notifyListeners();
      return ProviderResponse.success;
    } catch (e) {
      return ProviderResponse.error;
    }
  }

  Future<ProviderResponse> getBanners() async {
    try {
      List<OfferBanner> banners = [];

      final response = await _cloud.collection('banner').get();

      for (var element in response.docs) {
        final data = element.data();

        banners.add(OfferBanner(
            id: element.id,
            fileName: data["fileName"],
            imageID: data["imageID"],
            imageUrl: data["imageURL"]));
      }

      _offerBanners = banners;

      notifyListeners();
      return ProviderResponse.success;
    } catch (e) {
      return ProviderResponse.error;
    }
  }

  Future<ProviderResponse> deleteBanners({String? imageID, String? id}) async {
    try {
      if (imageID != "") {
        _storage.ref().child(imageID!).delete();
      }
      await _cloud.collection('banner').doc(id).delete();
      _offerBanners.removeWhere((element) => element.id == id);

      notifyListeners();
      return ProviderResponse.success;
    } catch (e) {
      return ProviderResponse.error;
    }
  }
}
