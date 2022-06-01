import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/provider/user_provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    double sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Container(
      margin: EdgeInsets.all(Dimensions.height10),
      child: Row(
        children: [
          Text(
            'Subtotal ',
            style: TextStyle(
              fontSize: Dimensions.font20,
            ),
          ),
          Text(
            '₦$sum',
            style: TextStyle(
              fontSize: Dimensions.font20,
              fontWeight: FontWeight.bold,
              color: Colors.cyan
            ),
          ),
        ],
      ),
    );
  }
}
