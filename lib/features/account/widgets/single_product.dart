import 'package:flutter/material.dart';

import 'package:shopp/constants/dimensions.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  const SingleProduct({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 / 2),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(Dimensions.width10 / 2),
          color: Colors.transparent,
        ),
        child: Container(
          width: Dimensions.width45 * 4,
          padding: EdgeInsets.all(Dimensions.height10),
          child: Image.network(
            image,
            fit: BoxFit.fitHeight,
            width: Dimensions.width45 * 4,
          ),
        ),
      ),
    );
  }
}
