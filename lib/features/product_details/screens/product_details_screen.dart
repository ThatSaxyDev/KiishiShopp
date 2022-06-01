import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shopp/common/widgets/custom_button.dart';
import 'package:shopp/common/widgets/stars.dart';

import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/constants/global_variables.dart';
import 'package:shopp/constants/utils.dart';
import 'package:shopp/features/product_details/services/product_details_services.dart';
import 'package:shopp/features/search/screens/search_screen.dart';
import 'package:shopp/models/product.dart';
import 'package:shopp/provider/user_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  double averageRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }
    if (totalRating != 0) {
      averageRating = totalRating / widget.product.rating!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
      arguments: query,
    );
  }

  void addToCart() {
    productDetailsServices.addToCart(
      context: context,
      product: widget.product,
    );
    showSnackBar(context, 'Added to your cart');
  }

  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.id!,
                    style: const TextStyle(fontSize: 14),
                  ),
                  Stars(rating: averageRating),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.height20,
                horizontal: Dimensions.width10,
              ),
              child: Text(
                widget.product.name,
                style: TextStyle(
                    fontSize: Dimensions.font19, fontWeight: FontWeight.bold),
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map(
                (i) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.contain,
                      height: Dimensions.height100 * 2,
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                autoPlay: true,
                viewportFraction: 1,
                height: Dimensions.height100 * 3,
              ),
            ),
            Container(
              color: Colors.white30,
              height: 4,
            ),
            Padding(
              padding: EdgeInsets.all(Dimensions.height8),
              child: RichText(
                text: TextSpan(
                  text: 'Deal Price: ',
                  style: TextStyle(
                    fontSize: Dimensions.font16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: '₦${widget.product.price}',
                      style: TextStyle(
                        fontSize: Dimensions.font22,
                        fontWeight: FontWeight.w500,
                        color: GlobalVariables.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Dimensions.height8),
              child: Text(widget.product.description),
            ),
            Container(
              color: Colors.white30,
              height: 4,
            ),
            Padding(
              padding: EdgeInsets.all(
                Dimensions.height10,
              ),
              child: CustomButton(
                text: 'Buy Now',
                onTap: () {},
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            Padding(
              padding: EdgeInsets.all(
                Dimensions.height10,
              ),
              child: CustomButton(
                text: 'Add To Cart',
                onTap: addToCart,
                color: const Color.fromRGBO(254, 216, 19, 1),
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            Container(
              color: Colors.white30,
              height: 4,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.height8,
                vertical: Dimensions.height8,
              ),
              child: Text(
                'Rate The Product',
                style: TextStyle(
                  fontSize: Dimensions.font22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RatingBar.builder(
              initialRating: myRating,
              itemCount: 5,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: GlobalVariables.secondaryColor,
              ),
              onRatingUpdate: (rating) {
                productDetailsServices.rateProduct(
                  context: context,
                  product: widget.product,
                  rating: rating,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
