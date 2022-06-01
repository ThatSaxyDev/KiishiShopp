import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/features/cart/services/cart_services.dart';
import 'package:shopp/features/product_details/services/product_details_services.dart';
import 'package:shopp/models/product.dart';
import 'package:shopp/provider/user_provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();

  void increaseQuantity(Product product) {
    productDetailsServices.addToCart(
      context: context,
      product: product,
    );
  }

  void decreaseQuantity(Product product) {
    cartServices.removeFromCart(
      context: context,
      product: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];

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
                    child: const Text(
                      'Eligible for free shipping',
                      style: TextStyle(color: Colors.grey),
                    ),
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
        Container(
          margin: EdgeInsets.all(Dimensions.height10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[600]!,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radius20 / 4),
                  color: Colors.grey[600],
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => decreaseQuantity(product),
                      child: Container(
                        width: Dimensions.width10 * 3.5,
                        height: Dimensions.height10 * 3.2,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.remove,
                          size: Dimensions.iconSize10 * 1.8,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Container(
                        color: Colors.grey[400],
                        width: Dimensions.width10 * 3.5,
                        height: Dimensions.height10 * 3.2,
                        alignment: Alignment.center,
                        child: Text(
                          quantity.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => increaseQuantity(product),
                      child: Container(
                        width: Dimensions.width10 * 3.5,
                        height: Dimensions.height10 * 3.2,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.add,
                          size: Dimensions.iconSize10 * 1.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
