import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'package:shopp/common/widgets/custom_button.dart';
import 'package:shopp/common/widgets/custom_textfield.dart';
import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/constants/utils.dart';
import 'package:shopp/features/address/services/address_services.dart';
import 'package:shopp/features/address/widgets/payment_bottom_modal.dart';
import 'package:shopp/provider/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = '';

  final AddressServices addressServices = AddressServices();

  @override
  void dispose() {
    super.dispose();
    flatController.dispose();
    streetController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void onPayResult() {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );

  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = '';

    bool isForm = flatController.text.isNotEmpty ||
        streetController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatController.text}, ${streetController.text}, ${pincodeController.text}, ${cityController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR!');
    }
    //print(addressToBeUsed);
    showMaterialModalBottomSheet(
      context: context,
      builder: (BuildContext context) => PaymentBottomModal(
        confirmPayment: () {
          onPayResult();
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    // var address = 'Some fake address';
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
          title: const Text('Confirm Address'),
          centerTitle: false,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.width10),
            child: Column(
              children: [
                if (address.isNotEmpty)
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[600]!)),
                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.height8),
                          child: Text(
                            address,
                            style: TextStyle(
                              fontSize: Dimensions.font19,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.height20),
                        child: Text(
                          'OR',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.font19),
                        ),
                      ),
                    ],
                  ),
                Form(
                  key: _addressFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: flatController,
                        hintText: 'Flat/House No/Building',
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      CustomTextField(
                        controller: streetController,
                        hintText: 'Area/Street',
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      CustomTextField(
                        controller: pincodeController,
                        hintText: 'ZipCode',
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      CustomTextField(
                        controller: cityController,
                        hintText: 'Town/City',
                      ),
                      SizedBox(
                        height: Dimensions.height45,
                      ),
                      CustomButton(
                        text: 'Pay',
                        onTap: () => payPressed(address),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
