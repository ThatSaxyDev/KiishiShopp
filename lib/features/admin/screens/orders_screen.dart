import 'package:flutter/material.dart';
import 'package:shopp/common/widgets/loader.dart';
import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/features/account/widgets/single_product.dart';
import 'package:shopp/features/admin/services/admin_services.dart';
import 'package:shopp/features/order_details/screens/order_details_screen.dart';
import 'package:shopp/models/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return Padding(
                padding:
                    EdgeInsets.symmetric(vertical: Dimensions.height10 / 2),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      OrderDetailsScreen.routeName,
                      arguments: orderData,
                    );
                  },
                  child: SizedBox(
                    height: Dimensions.height10 * 14,
                    child: SingleProduct(
                      image: orderData.products[0].images[0],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
