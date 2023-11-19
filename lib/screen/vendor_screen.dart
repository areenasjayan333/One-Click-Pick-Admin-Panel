import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_admin/provider/VendorProvider.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({super.key});
  static const String routename = '/vendorScreen';
  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      await Provider.of<VendorProvider>(context, listen: false)
          .getBecomeVendorRequests();

      setState(() {
        _isLoading = false;
      });
      _isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<VendorProvider>(context).vendorRequests;
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Vendor',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 8, 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ShopName",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Name",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text("Address",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  )),
              SizedBox(
                width: 5,
              ),
              Text("Phone Number",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  )),
              SizedBox(
                width: 5,
              ),
              Text("Response",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  )),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
        _isLoading
            ? CircularProgressIndicator()
            : Expanded(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(data[index].shopName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  )),
                              Text(data[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  )),
                              Text(data[index].address,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  )),
                              Text(data[index].phoneNo,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 95, 233, 118),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        height: 35,
                                        width: 110,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text('Accept',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              )),
                                        ),
                                      )),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  InkWell(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 233, 95, 98),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        height: 35,
                                        width: 110,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text('Delete',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              )),
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
