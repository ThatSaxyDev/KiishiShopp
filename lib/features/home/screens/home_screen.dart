import 'package:flutter/material.dart';

import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/features/home/widgets/address_box.dart';
import 'package:shopp/features/home/widgets/carousel_image.dart';
import 'package:shopp/features/home/widgets/deal_of_the_day.dart';
import 'package:shopp/features/home/widgets/top_categories.dart';
import 'package:shopp/features/search/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
      arguments: query,
    );
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
          children: [
            const AddressBox(),
            SizedBox(
              height: Dimensions.height10,
            ),
            const TopCategories(),
            SizedBox(
              height: Dimensions.height10,
            ),
            const CarouselImage(),
            SizedBox(
              height: Dimensions.height15,
            ),
            const DealOfTheDay(),
          ],
        ),
      ),
    );
  }
}
