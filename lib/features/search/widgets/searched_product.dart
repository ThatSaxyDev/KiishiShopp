import 'package:flutter/material.dart';
import 'package:shopp/common/widgets/stars.dart';
import 'package:shopp/constants/dimensions.dart';

import 'package:shopp/models/product.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    for (int i=0; i<product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    double averageRating = 0;
    if (totalRating != 0) {
      averageRating = totalRating / product.rating!.length;
    }
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitWidth,
                height: Dimensions.height10 * 13.5,
                width: Dimensions.width10 * 13.5,
              ),
              Column(
                children: [
                  Container(
                    width: Dimensions.width10 * 23.5,
                    padding: EdgeInsets.only(
                      left: Dimensions.width10,
                      top: Dimensions.height10 / 2,
                    ),
                    child: Text(
                      product.name,
                      style: TextStyle(fontSize: Dimensions.font16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: Dimensions.width10 * 23.5,
                    padding: EdgeInsets.only(
                      left: Dimensions.width10,
                      top: Dimensions.height10 / 2,
                    ),
                    child: Stars(rating: averageRating),
                  ),
                  Container(
                    width: Dimensions.width10 * 23.5,
                    padding: EdgeInsets.only(
                      left: Dimensions.width10,
                      top: Dimensions.height10 / 2,
                    ),
                    child: Text(
                      '₦${product.price}',
                      style: TextStyle(
                        fontSize: Dimensions.font20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: Dimensions.width10 * 23.5,
                    padding: EdgeInsets.only(
                      left: Dimensions.width10,
                      top: Dimensions.height10 / 5,
                    ),
                    child: const Text('Eligible for free shipping', style: TextStyle(color: Colors.grey),),
                  ),
                  Container(
                    width: Dimensions.width10 * 23.5,
                    padding: EdgeInsets.only(
                      left: Dimensions.width10,
                      top: Dimensions.height10 / 2,
                    ),
                    child: const Text(
                      'In Stock',
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
