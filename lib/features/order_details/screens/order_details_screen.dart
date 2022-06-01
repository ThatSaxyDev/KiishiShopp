import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopp/common/widgets/custom_button.dart';
import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/constants/global_variables.dart';
import 'package:shopp/features/admin/services/admin_services.dart';
import 'package:shopp/features/search/screens/search_screen.dart';

import 'package:shopp/models/order.dart';
import 'package:shopp/provider/user_provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailsScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
      arguments: query,
    );
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

//! ONLY FOR ADMIN
  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
      context: context,
      status: status + 1,
      order: widget.order,
      onSuccess: () {
        setState(() {
          currentStep += 1;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
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
        child: Padding(
          padding: EdgeInsets.all(Dimensions.height10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'View order details',
                style: TextStyle(
                  fontSize: Dimensions.font22,
                  fontWeight: FontWeight.bold,
                  color: GlobalVariables.secondaryColor,
                ),
              ),
              SizedBox(
                height: Dimensions.height20 / 5,
              ),
              Container(
                padding: EdgeInsets.all(Dimensions.height10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[600]!,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Date:      ${DateFormat().format(
                        DateTime.fromMillisecondsSinceEpoch(
                            widget.order.orderedAt),
                      )}',
                      style: TextStyle(
                        fontSize: Dimensions.font15,
                      ),
                    ),
                    Text(
                      'Order ID:           ${widget.order.id}',
                      style: TextStyle(
                        fontSize: Dimensions.font15,
                      ),
                    ),
                    Text(
                      'Order Total:      ₦${widget.order.totalPrice}',
                      style: TextStyle(
                        fontSize: Dimensions.font15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.height15,
              ),
              Text(
                'Purchase Details',
                style: TextStyle(
                  fontSize: Dimensions.font22,
                  fontWeight: FontWeight.bold,
                  color: GlobalVariables.secondaryColor,
                ),
              ),
              SizedBox(
                height: Dimensions.height20 / 5,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[600]!,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: Dimensions.height120,
                            width: Dimensions.width120,
                          ),
                          SizedBox(
                            width: Dimensions.width10 / 2,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.products[i].name,
                                  style: TextStyle(
                                    fontSize: Dimensions.font16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: Dimensions.height10 / 2,
                                ),
                                Text(
                                  'Qty: ${widget.order.quantity[i]}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Center(
                child: Text(
                  'Tracking',
                  style: TextStyle(
                    fontSize: Dimensions.font22,
                    fontWeight: FontWeight.bold,
                    color: GlobalVariables.secondaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.height10 / 5,
              ),
              Stepper(
                physics: const ClampingScrollPhysics(),
                currentStep: currentStep,
                controlsBuilder: (context, details) {
                  if (user.type == 'admin') {
                    return Padding(
                      padding: EdgeInsets.all(Dimensions.height10),
                      child: CustomButton(
                        text: 'Done',
                        onTap: () => changeOrderStatus(details.currentStep),
                      ),
                    );
                  }
                  return const SizedBox();
                },
                steps: [
                  Step(
                      title: const Text('Pending'),
                      content: const Text(
                        'Your order is yet to be delivered',
                      ),
                      isActive: currentStep > 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed),
                  Step(
                      title: const Text('Completed'),
                      content: const Text(
                        'Your order has been delivered, you are yet to sign',
                      ),
                      isActive: currentStep > 1,
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed),
                  Step(
                      title: const Text('Received'),
                      content: const Text(
                        'Your order has been delivered and signed by you',
                      ),
                      isActive: currentStep > 2,
                      state: currentStep > 2
                          ? StepState.complete
                          : StepState.indexed),
                  Step(
                      title: const Text('Delivered'),
                      content: const Text(
                        'Your order has been delivered and signed by you',
                      ),
                      isActive: currentStep >= 3,
                      state: currentStep >= 3
                          ? StepState.complete
                          : StepState.indexed),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
