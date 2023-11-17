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
      print('haaaai');

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
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            'Vendor',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("shopname"),
              Text("shopname"),
              Text("shopname"),
              Text("shopname"),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Accept'),
                  Text('Delete'),
                ],
              ),
            ],
          ),
          _isLoading
              ? CircularProgressIndicator()
              : SizedBox(
                  height: 500,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, index) => Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data[index].shopName),
                          Text(data[index].name),
                          Text(data[index].address),
                          Text(data[index].phoneNo),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Accept'),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Delete'),
                              ),
                            ],
                          ),
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
