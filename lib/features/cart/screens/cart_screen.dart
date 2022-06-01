import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/common/widgets/custom_button.dart';
import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/features/address/screens/address_screen.dart';
import 'package:shopp/features/cart/widgets/cart_product.dart';
import 'package:shopp/features/cart/widgets/cart_subtotal.dart';
import 'package:shopp/features/home/widgets/address_box.dart';
import 'package:shopp/features/search/screens/search_screen.dart';
import 'package:shopp/provider/user_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
      arguments: query,
    );
  }

  void navigateToAddressScreen(double sum) {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: sum.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    double sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              // gradient: GlobalVariables.appBarGradient,
              color: Colors.transparent,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: Dimensions.height42,
                  margin: EdgeInsets.only(left: Dimensions.width15),
                  child: Material(
                    borderRadius: BorderRadius.circular(Dimensions.radius7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.only(top: Dimensions.height10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.radius7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.radius7),
                          ),
                          borderSide: const BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Kiishi\'s Ends',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: Dimensions.height42,
                margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child: Icon(
                  Icons.mic,
                  size: Dimensions.iconSize24,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBox(),
            const CartSubtotal(),
            Padding(
              padding: EdgeInsets.all(Dimensions.height8),
              child: CustomButton(
                text: user.cart.length == 1
                    ? 'Proceed to Buy ${user.cart.length} item'
                    : 'Proceed to Buy ${user.cart.length} items',
                onTap: () => navigateToAddressScreen(sum),
              ),
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            Container(
              color: Colors.grey[600],
              height: 1,
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: user.cart.length,
              itemBuilder: (context, index) {
                return CartProduct(index: index);
              },
            )
          ],
        ),
      ),
    );
  }
}
