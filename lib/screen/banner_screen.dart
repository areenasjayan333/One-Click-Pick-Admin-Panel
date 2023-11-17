import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shopping_admin/Utilities/enum_helper.dart';
import 'package:shopping_admin/Utilities/reusables.dart';
import 'package:shopping_admin/provider/bannerProvider.dart';

class BannerScreen extends StatefulWidget {
  static const String routename = '/bannerScreen';

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  dynamic _image;
  String? fileName;
  bool isLoading = false;
  bool mainLoader = false;
  bool _isInit = true;

  Future<ProviderResponse> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
        allowCompression: true,
      );

      if (result != null) {
        setState(() {
          mainLoader = true;

          _image = result.files.first.bytes;

          fileName = result.files.first.name;
        });

        setState(() {
          mainLoader = false;
        });
      }

      return ProviderResponse.success;
    } catch (e) {
      return ProviderResponse.error;
    }
  }

  uploadImage() async {
    if (_image != null) {
      setState(() {
        isLoading = true;
      });
      final offerBanner = OfferBanner(
        imageID: "",
        imageUrl: "",
        image: _image,
        fileName: fileName!,
      );
      await Provider.of<OfferBannerProvider>(context, listen: false)
          .addBanner(offerBanner);

      setState(() {
        isLoading = false;
      });

      displaySnackBar(text: 'Banner has been uploaded..', context: context);

      _image = null;
    } else {
      displaySnackBar(text: 'Please select an image..', context: context);
    }
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        mainLoader = true;
      });

      await Provider.of<OfferBannerProvider>(context, listen: false)
          .getBanners();
      print('haaaai');

      setState(() {
        mainLoader = false;
      });
      _isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<OfferBannerProvider>(context).offerBanners;
    final orientation = MediaQuery.of(context).orientation;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Banner',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 34,
              ),
            ),
          ),
          isLoading
              ? CircularProgressIndicator()
              : InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _pickImage(),
                  child: _image != null
                      ? Container(
                          width: 200,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: MemoryImage(
                                _image,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ))
                      : DottedBorder(
                          color: Colors.grey,
                          radius: const Radius.circular(12.0),
                          borderType: BorderType.RRect,
                          padding: const EdgeInsets.only(
                              left: 80, right: 80, top: 40, bottom: 40),
                          child: Column(
                            children: [
                              Icon(
                                Icons.cloud_upload_outlined,
                                size: 60,
                                color: Colors.grey,
                              ),
                              Text('Click to Upload Image')
                            ],
                          ),
                        )),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                uploadImage();
              },
              child: Text('Upload')),
          SizedBox(
            height: 40,
            width: double.infinity,
          ),
          mainLoader
              ? CircularProgressIndicator()
              : SizedBox(
                  height: 300,
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 0,
                        mainAxisExtent: 250,
                        crossAxisCount:
                            (orientation == Orientation.landscape) ? 4 : 1),
                    itemCount: data.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        CachedNetworkImage(
                            imageUrl: data[index].imageUrl,
                            imageBuilder: (context, imageProvider) => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  height: 150,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                            placeholder: (context, url) => Container(
                                height: 150,
                                width: 300,
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.fitHeight),
                        Text(data[index].fileName),
                        ElevatedButton.icon(
                            onPressed: () async {
                              await Provider.of<OfferBannerProvider>(context,
                                      listen: false)
                                  .deleteBanners(
                                      imageID: data[index].imageID,
                                      id: data[index].id);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            label: Text('Delete'))
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
