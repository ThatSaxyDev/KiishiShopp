import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopp/common/widgets/custom_button.dart';
import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/constants/global_variables.dart';
import 'package:shopp/provider/user_provider.dart';

class PaymentBottomModal extends StatelessWidget {
  final VoidCallback confirmPayment;
  const PaymentBottomModal({
    Key? key,
    required this.confirmPayment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    double sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return SizedBox(
      height: Dimensions.height100 * 2.5,
      child: Padding(
        padding: EdgeInsets.all(Dimensions.height15),
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.height10,
            ),
            Text(
              'Pay Total Amount',
              style: TextStyle(
                fontSize: Dimensions.font21,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            Container(
              color: Colors.white24,
              height: 1,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            Text(
              '₦$sum',
              style: TextStyle(
                fontSize: Dimensions.font20 * 2,
                fontWeight: FontWeight.bold,
                color: GlobalVariables.secondaryColor,
              ),
            ),
            SizedBox(
              height: Dimensions.height30,
            ),
            CustomButton(
              text: 'Confirm Payment',
              onTap: confirmPayment,
            )
          ],
        ),
      ),
    );
  }
}
