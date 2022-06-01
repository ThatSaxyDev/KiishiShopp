import 'package:flutter/material.dart';
import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/features/account/widgets/below_app_bar.dart';
import 'package:shopp/features/account/widgets/orders.dart';
import 'package:shopp/features/account/widgets/top_buttons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: Dimensions.width15),
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                      ),
                    ),
                    const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const BelowAppBar(),
          SizedBox(
            height: Dimensions.height20,
          ),
          const TopButtons(),
          SizedBox(
            height: Dimensions.height20,
          ),
          const Orders(),
        ],
      ),
    );
  }
}
