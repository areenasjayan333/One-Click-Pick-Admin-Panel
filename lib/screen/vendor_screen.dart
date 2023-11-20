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
    final orientation = MediaQuery.of(context).orientation;
    final data = Provider.of<VendorProvider>(context).vendorRequests;
    return (orientation == Orientation.landscape)
        ? Column(
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
                            itemCount: 17,
                            itemBuilder: (BuildContext context, index) =>
                                Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(data[0].shopName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          )),
                                      Text(data[0].name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          )),
                                      Text(data[0].address,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          )),
                                      Text(data[0].phoneNo,
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
                                                  color: Color.fromARGB(
                                                      255, 95, 233, 118),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                height: 35,
                                                width: 110,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text('Accept',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                                  color: Color.fromARGB(
                                                      255, 233, 95, 98),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                height: 35,
                                                width: 110,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text('Delete',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
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
                          )),
                    )
            ],
          )
        : Column(
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
              _isLoading
                  ? CircularProgressIndicator()
                  : SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.all(7.5),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff313759),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].shopName,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                data[index].name,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 143, 148, 188)),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                data[index].phoneNo,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 106, 112, 161)),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                data[index].address,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 94, 100, 147)),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      // await Provider.of<CategoryProvider>(context,
                                      //         listen: false)
                                      //     .deleteCategory(
                                      //         imageID: data[index].imageID,
                                      //         id: data[index].id);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 233, 95, 98),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      height: 35,
                                      width: MediaQuery.of(context).size.width *
                                          0.42,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Delete',
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      // await Provider.of<CategoryProvider>(context,
                                      //         listen: false)
                                      //     .deleteCategory(
                                      //         imageID: data[index].imageID,
                                      //         id: data[index].id);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 95, 233, 118),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      height: 35,
                                      width: MediaQuery.of(context).size.width *
                                          0.42,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Accept',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          );
  }
}
