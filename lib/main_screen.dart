import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:shopping_admin/screen/banner_screen.dart';
import 'package:shopping_admin/screen/category_screen.dart';
import 'package:shopping_admin/screen/dashboard_screen.dart';
import 'package:shopping_admin/screen/order_screen.dart';
import 'package:shopping_admin/screen/vendor_screen.dart';
import 'package:shopping_admin/screen/withdrawal_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget selectedRoute = DashBoardScreen();

  selectedScreen(item) {
    switch (item.route) {
      case DashBoardScreen.routename:
        setState(() {
          selectedRoute = DashBoardScreen();
        });

        break;

      case OrderScreen.routename:
        setState(() {
          selectedRoute = OrderScreen();
        });

        break;

      case VendorScreen.routename:
        setState(() {
          selectedRoute = VendorScreen();
        });

        break;

      case WithdrawalScreen.routename:
        setState(() {
          selectedRoute = WithdrawalScreen();
        });

        break;

      case BannerScreen.routename:
        setState(() {
          selectedRoute = BannerScreen();
        });

        break;

      case CategoryScreen.routename:
        setState(() {
          selectedRoute = CategoryScreen();
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final orientation = MediaQuery.of(context).orientation;
    return AdminScaffold(
        body: AdminScaffold(
            backgroundColor: Color(0xff242c4b),
            appBar: AppBar(
              toolbarHeight: 70,
              foregroundColor: Colors.white,
              backgroundColor: Color(0xff313759),
              title: const Text(
                'One-Click Pick Admin',
                style: TextStyle(color: Colors.white),
              ),
            ),
            sideBar: SideBar(
              // width: 260,
              textStyle: TextStyle(
                  color: Color(0xff678dac),
                  fontSize: 14,
                  fontWeight: FontWeight.w200),
              iconColor: Color(0xff678dac),
              activeTextStyle:
                  TextStyle(color: Color.fromARGB(255, 21, 158, 26)),
              activeBackgroundColor: Color.fromARGB(255, 201, 32, 116),
              backgroundColor: Color(0xff313759),
              borderColor: Colors.transparent,
              items: const [
                AdminMenuItem(
                  title: 'Dashboard',
                  route: DashBoardScreen.routename,
                  icon: Icons.dashboard,
                ),
                AdminMenuItem(
                  title: 'Order',
                  route: OrderScreen.routename,
                  icon: Icons.shop_2_outlined,
                ),
                AdminMenuItem(
                  title: 'Vendor',
                  route: VendorScreen.routename,
                  icon: Icons.storefront_sharp,
                ),
                AdminMenuItem(
                  title: 'Withdraw',
                  route: WithdrawalScreen.routename,
                  icon: Icons.payments_outlined,
                ),
                AdminMenuItem(
                  title: 'Banner',
                  route: BannerScreen.routename,
                  icon: Icons.view_carousel_outlined,
                ),
                AdminMenuItem(
                  title: 'Category',
                  route: CategoryScreen.routename,
                  icon: Icons.category_outlined,
                ),
              ],
              selectedRoute: '/',
              onSelected: (item) {
                selectedScreen(item);
              },
              // header: Container(
              //   height: 50,
              //   width: double.infinity,
              //   color: Colors.white,
              //   child: const Center(
              //     child: Text(
              //       'header',
              //       style: TextStyle(
              //         color: Colors.black,
              //       ),
              //     ),
              //   ),
              // ),
              // footer: Container(
              //   height: 50,
              //   width: double.infinity,
              //   color: const Color(0xff444444),
              //   child: const Center(
              //     child: Text(
              //       'footer',
              //       style: TextStyle(
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
            ),
            body: selectedRoute));
  }
}
