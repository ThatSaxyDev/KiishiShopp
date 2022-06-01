import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/provider/user_provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: const BoxDecoration(
        // gradient: GlobalVariables.appBarGradient,
        color: Colors.transparent,
      ),
      padding: EdgeInsets.only(
        left: Dimensions.width10,
        right: Dimensions.width10,
        bottom: Dimensions.height10,
        top: Dimensions.height10,
      ),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: 'Hello, ',
              style: TextStyle(
                fontSize: Dimensions.font21,
                color: Colors.white,
              ),
              children: [
                TextSpan(
                  text: user.name,
                  style: TextStyle(
                    fontSize: Dimensions.font20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
