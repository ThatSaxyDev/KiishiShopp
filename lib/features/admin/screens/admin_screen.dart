import 'package:flutter/material.dart';
import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/constants/global_variables.dart';
import 'package:shopp/features/admin/screens/analytics_screen.dart';
import 'package:shopp/features/admin/screens/orders_screen.dart';
import 'package:shopp/features/admin/screens/products_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomNavBarWidth = Dimensions.width42;
  double bottomBorderWidth = Dimensions.width10 / 2;

  List<Widget> pages = [
    const ProductsScreen(),
    const AnalyticsScreen(),
    const OrdersScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              // gradient: GlobalVariables.appBarGradient,
              color: Colors.black,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Dimensions.width120 * 2,
                //color: Colors.black,
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/kiishi.png',
                  color: Colors.white,
                ),
              ),
              const Text(
                'Admin',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: Dimensions.font26,
        onTap: updatePage,
        items: [
          //HOME
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBorderWidth,
                  ),
                ),
              ),
              child: Icon(
                _page == 0 ? Icons.home_filled : Icons.home_outlined,
              ),
            ),
            label: '',
          ),

          // ANALYTICS
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBorderWidth,
                  ),
                ),
              ),
              child: Icon(
                _page == 1 ? Icons.analytics : Icons.analytics_outlined,
              ),
            ),
            label: '',
          ),

          // ORDERS
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBorderWidth,
                  ),
                ),
              ),
              child: Icon(
                _page == 2 ? Icons.inbox : Icons.inbox_outlined,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
