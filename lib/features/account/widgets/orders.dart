import 'package:flutter/material.dart';
import 'package:shopp/common/widgets/loader.dart';
import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/constants/global_variables.dart';
import 'package:shopp/features/account/services/account_services.dart';
import 'package:shopp/features/account/widgets/single_product.dart';
import 'package:shopp/features/order_details/screens/order_details_screen.dart';
import 'package:shopp/models/order.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(
      context: context,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: Dimensions.width15),
                    child: Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: Dimensions.font19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: Dimensions.width15),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        // fontSize: Dimensions.font19,
                        fontWeight: FontWeight.w600,
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ),
                  ),
                ],
              ),
              // display orders
              Container(
                height: Dimensions.height45 * 4,
                padding: EdgeInsets.only(
                  left: Dimensions.width10,
                  top: Dimensions.height20,
                  right: 0,
                ),
                // color: Colors.red,
                child: ListView.builder(
                  // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          OrderDetailsScreen.routeName,
                          arguments: orders![index],
                        );
                      },
                      child: SingleProduct(
                        image: orders![index].products[0].images[0],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
