import 'package:flutter/material.dart';
import 'package:shopp/common/widgets/loader.dart';

import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/features/home/services/home_services.dart';
import 'package:shopp/features/product_details/screens/product_details_screen.dart';
import 'package:shopp/models/product.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              // gradient: GlobalVariables.appBarGradient,
              color: Colors.black,
            ),
          ),
          title: Text(
            widget.category,
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width15,
                    vertical: Dimensions.height10,
                  ),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shopping for ${widget.category}',
                    style: TextStyle(
                      fontSize: Dimensions.font20,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    //height: Dimensions.height10 * 17,
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: productList!.length,
                      //scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: Dimensions.width15),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        //childAspectRatio: 2,
                        //mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final product = productList![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ProductDetailsScreen.routeName,
                              arguments: product,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Dimensions.height10 * 13,
                                child: Padding(
                                  padding: EdgeInsets.all(Dimensions.height10),
                                  child: Image.network(
                                    product.images[0],
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(
                                  left: Dimensions.width10 / 2,
                                  top: Dimensions.height10 / 2,
                                  right: Dimensions.width15,
                                ),
                                child: Text(
                                  product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
