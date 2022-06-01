import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/constants/global_variables.dart';
import 'package:shopp/provider/user_provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: Dimensions.height20 * 2,
      decoration: const BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [
        //     Color.fromARGB(255, 114, 226, 221),
        //     Color.fromARGB(255, 162, 236, 233),
        //   ],
        //   stops: [0.5, 1.0],
        // ),
        color: Colors.transparent,
      ),
      padding: EdgeInsets.only(left: Dimensions.width10),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
            color: GlobalVariables.secondaryColor,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: Dimensions.width10 / 2),
              child: Text(
                'Delivery to ${user.name} - ${user.address}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Dimensions.width10 / 2,
              top: Dimensions.width10 / 5,
            ),
            child: Icon(
              Icons.arrow_drop_down_outlined,
              size: Dimensions.iconSize24,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
