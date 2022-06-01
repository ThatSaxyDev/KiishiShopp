import 'package:flutter/material.dart';
import 'package:shopp/common/widgets/loader.dart';
import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/constants/global_variables.dart';
import 'package:shopp/features/home/services/home_services.dart';
import 'package:shopp/features/product_details/screens/product_details_screen.dart';
import 'package:shopp/models/product.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({Key? key}) : super(key: key);

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfTheDay();
  }

  void fetchDealOfTheDay() async {
    product = await homeServices.fetchDealOfTheDay(context: context);
    setState(() {});
  }

  void navigateToDetailsScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailsScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToDetailsScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: Dimensions.width10),
                      child: Text(
                        'Deal of the day',
                        style: TextStyle(fontSize: Dimensions.font20),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      fit: BoxFit.fitHeight,
                      height: Dimensions.height120 * 2,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(
                        left: Dimensions.width15,
                        top: Dimensions.height10 / 2,
                      ),
                      child: Text(
                        '₦${product!.price}',
                        style: TextStyle(
                            fontSize: Dimensions.font19,
                            color: GlobalVariables.secondaryColor),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(
                        left: Dimensions.width15,
                        top: Dimensions.height10 / 2,
                        right: Dimensions.width20 * 2,
                        bottom: Dimensions.height10,
                      ),
                      child: Text(
                        product!.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map(
                              (e) => Image.network(
                                e,
                                fit: BoxFit.fitWidth,
                                width: Dimensions.width100,
                                height: Dimensions.height100,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: Dimensions.width15,
                        top: Dimensions.height15,
                        bottom: Dimensions.height15,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See all deals',
                        style: TextStyle(
                          color: Colors.cyan[300],
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
