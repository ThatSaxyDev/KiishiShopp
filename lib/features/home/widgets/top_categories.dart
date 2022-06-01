import 'package:flutter/material.dart';
import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/constants/global_variables.dart';
import 'package:shopp/features/home/screens/category_deals_screen.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height30 * 2,
      child: ListView.builder(
        shrinkWrap: true,
        itemExtent: Dimensions.width15 * 5,
        scrollDirection: Axis.horizontal,
        itemCount: GlobalVariables.categoryImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navigateToCategoryPage(
                context, GlobalVariables.categoryImages[index]['title']!),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radius50),
                    child: Image.asset(
                      GlobalVariables.categoryImages[index]['image']!,
                      fit: BoxFit.cover,
                      height: Dimensions.height20 * 2,
                      width: Dimensions.width20 * 2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  GlobalVariables.categoryImages[index]['title']!,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Dimensions.iconSize24 / 2,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
