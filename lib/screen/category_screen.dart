import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_admin/provider/categoryProvider.dart';

import '../Utilities/enum_helper.dart';
import '../Utilities/reusables.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  static const String routename = '/categoryScreen';
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  dynamic _image;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _name = TextEditingController();
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

  Future<ProviderResponse> _save() async {
    try {
      if (_formKey.currentState!.validate()) {
        if (_image != null) {
          setState(() {
            isLoading = true;
          });

          final category = ShopCategory(
            imageID: "",
            imageUrl: "",
            image: _image,
            fileName: fileName!,
            categoryName: _name.text,
          );

          await Provider.of<CategoryProvider>(context, listen: false)
              .addCategory(category);

          setState(() {
            isLoading = false;
          });

          displaySnackBar(
              text: 'Category has been uploaded..', context: context);

          _image = null;
          _name.clear();
        } else {
          displaySnackBar(text: 'Please upload image..', context: context);
        }
      } else {
        displaySnackBar(text: 'Please enter category name..', context: context);
      }
      return ProviderResponse.success;
    } catch (e) {
      print(e);
      return ProviderResponse.error;
    }
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        mainLoader = true;
      });

      await Provider.of<CategoryProvider>(context, listen: false)
          .getCategories();
      print('haaaai');

      setState(() {
        mainLoader = false;
      });
      _isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CategoryProvider>(context).categories;
    final orientation = MediaQuery.of(context).orientation;
    return SingleChildScrollView(
      // physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Category',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          isLoading
              ? CircularProgressIndicator()
              : Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color(0xff30355b),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                          hoverColor: Color(0xff313759),
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => _pickImage(),
                          child: _image != null
                              ? Container(
                                  width: 300,
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
                                  strokeWidth: 1.5,
                                  color: Color(0xff5b608e),
                                  radius: const Radius.circular(12.0),
                                  borderType: BorderType.RRect,
                                  padding: const EdgeInsets.only(
                                      left: 80, right: 80, top: 40, bottom: 40),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.cloud_upload_outlined,
                                        size: 60,
                                        color: Color(0xff5b608e),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Click to Upload Image',
                                        style: TextStyle(
                                          color: Color(0xff5b608e),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 320,
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            controller: _name,
                            decoration: InputDecoration(
                                fillColor: Color(0xff353a5e),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                hintText: 'Enter Category name',
                                hintStyle: TextStyle(color: Color(0xff5b608e))),
                            validator: (val) {
                              if ((RegExp(r'[0-9,-/#;*+()!@#_-]')
                                      .hasMatch(val!) ||
                                  (val.trim().length < 2))) {
                                return 'Enter a valid owner name';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                          onTap: () {
                            _save();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffffc212),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            height: 50,
                            width: 320,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Upload',
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
          SizedBox(
            height: 7.5,
            width: double.infinity,
          ),
          mainLoader
              ? CircularProgressIndicator()
              : SizedBox(
                  height: 290,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 0,
                        mainAxisExtent: 246,
                        crossAxisCount:
                            (orientation == Orientation.landscape) ? 4 : 1),
                    itemCount: data.length,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.all(7.5),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff313759),
                      ),
                      child: Column(
                        children: [
                          CachedNetworkImage(
                              imageUrl: data[index].imageUrl,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    height: 150,
                                    width: 300,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
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
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data[index].categoryName,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              InkWell(
                                  onTap: () async {
                                    await Provider.of<CategoryProvider>(context,
                                            listen: false)
                                        .deleteCategory(
                                            imageID: data[index].imageID,
                                            id: data[index].id);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 233, 95, 98),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    height: 35,
                                    width: 110,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Delete',
                                      ),
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
