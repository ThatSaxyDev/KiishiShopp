import 'package:flutter/material.dart';

import 'package:shopp/constants/dimensions.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AccountButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
        height: Dimensions.height20 * 2,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(Dimensions.radius50),
            color: Colors.transparent),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius50),
            ),
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
