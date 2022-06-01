import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:shopp/common/widgets/loader.dart';
import 'package:shopp/constants/dimensions.dart';
import 'package:shopp/constants/global_variables.dart';
import 'package:shopp/features/admin/models/sales.dart';
import 'package:shopp/features/admin/services/admin_services.dart';
import 'package:shopp/features/admin/widgets/category_products_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Row(
                children: [
                  Text(
                    'Total Sales: ',
                    style: TextStyle(
                        fontSize: Dimensions.font20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₦$totalSales',
                    style: TextStyle(
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.bold,
                      color: GlobalVariables.secondaryColor,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.height10 / 5),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(Dimensions.width10 / 2),
                    color: Colors.white,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.height10),
                    height: Dimensions.height10 * 25,
                    child: CategoryProductsChart(
                      seriesList: [
                        charts.Series(
                          id: 'Sales',
                          data: earnings!,
                          domainFn: (Sales sales, _) => sales.label,
                          measureFn: (Sales sales, _) => sales.earning,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
