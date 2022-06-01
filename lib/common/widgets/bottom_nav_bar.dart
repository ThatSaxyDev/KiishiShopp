import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/constants/global_variables.dart';
import 'package:shopp/features/account/screens/account_screen.dart';
import 'package:shopp/features/cart/screens/cart_screen.dart';
import 'package:shopp/features/home/screens/home_screen.dart';
import 'package:shopp/provider/user_provider.dart';

class BottomNavBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  double bottomNavBarWidth = Dimensions.width42;
  double bottomBorderWidth = Dimensions.width10 / 2;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
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

          // ACCOUNT, PROFILE
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
                _page == 1 ? Icons.person : Icons.person_outlined,
              ),
            ),
            label: '',
          ),

          // CART
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
              child: Badge(
                elevation: 0,
                badgeContent: userCartLen == 0
                    ? const Text('')
                    : Text(userCartLen.toString()),
                // badgeColor: Colors.red[400]!,
                badgeColor: Colors.transparent,
                child: Icon(
                  _page == 2
                      ? Icons.shopping_cart
                      : Icons.shopping_cart_outlined,
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
