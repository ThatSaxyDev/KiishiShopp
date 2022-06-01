import 'package:flutter/material.dart';
import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/features/account/services/account_services.dart';
import 'package:shopp/features/account/widgets/account_button.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Your orders',
              onTap: () {},
            ),
            AccountButton(
              text: 'Turn Seller',
              onTap: () {},
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            AccountButton(
              text: 'Your WishList',
              onTap: () {},
            ),
            AccountButton(
              text: 'Log out',
              onTap: () => AccountServices().logOut(context),
            ),
          ],
        ),
      ],
    );
  }
}
