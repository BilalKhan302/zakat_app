import 'package:flutter/material.dart';
import 'package:zakat_app/const/common.dart';
import '../services/services.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
class CalculateScreen extends StatefulWidget {
  const CalculateScreen({Key? key}) : super(key: key);

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {


  double zakatAmount = 0.0;
  int years = 0;
  int seletedIndex=0;
  bool _isFinished = false;
  TextEditingController ownerNameController=TextEditingController();
  TextEditingController sellingYearController=TextEditingController();
  TextEditingController purchasingYearController=TextEditingController();
  TextEditingController registrationNumberController=TextEditingController();
  TextEditingController vehicleIdController=TextEditingController();
  TextEditingController totalAmountController=TextEditingController();
  TextEditingController totalVehicleController=TextEditingController();
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  DateTime _selectedDate = DateTime.now();
  Map<DateTime, double> selectedDates = {};

  Future<void> calculateZakat() async {
    //
    // List<double> monthlyInstallments = selectedDates.values.toList();
    // int currentYear = DateTime.now().year;
    // int yearsOwned = currentYear - purchaseYear;
    // double vehicleValue = double.parse(totalAmountController.text); // Example value, replace with actual vehicle value
    //
    // if (yearsOwned >= 1) {
    //   zakatAmount = vehicleValue * 0.025;
    // } else {
    //   zakatAmount = 0.0;
    // }

    // Create a Vehicle object
    Vehicle vehicle =  Vehicle(
      ownerName: ownerNameController.text, // Corrected
      registrationNumber: registrationNumberController.text,// Corrected
      purchaseYear: int.parse(purchasingYearController.text),
      sellingYear: int.parse(sellingYearController.text),
      totalVehicle: int.parse(totalVehicleController.text), // Corrected
      totalAmount: double.parse(totalAmountController.text),
      vehicleId: int.parse(vehicleIdController.text),
      // monthlyInstallments: monthlyInstallments, // Corrected
    );
    final vehicleMap = vehicle.toMap();
    await dbHelper.insertVehicle(vehicleMap);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade400,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
           Container(
           child: Center(child: Text("Zakat App",style: TextStyle(
             fontSize: 30,
             fontWeight: FontWeight.bold,
             color: Colors.grey.shade400
           ),)),
           ).box.white.size(context.screenWidth, 150).color(primary).bottomRightRounded(value: 60).make(),
          20.heightBox,
              Column(
            children: [
              commonTextFormField(
                  hint: "Enter Selling year",
                  type: TextInputType.number,
                controller: sellingYearController
              ),
              10.heightBox,
              commonTextFormField(
                  hint: "Enter Purchasing year",
                  type: TextInputType.number,
                controller: purchasingYearController
              ),
              10.heightBox,
              commonTextFormField(
                  hint: "Enter Owner Name",
                  type: TextInputType.name,
                controller: ownerNameController
              ),
              10.heightBox,
              commonTextFormField(
                  hint: "Enter registration number",
                  type: TextInputType.multiline,
                controller: registrationNumberController
              ),
              10.heightBox,
              commonTextFormField(
                  hint: "Enter vehicle id",
                  type: TextInputType.multiline,
                controller: vehicleIdController
              ), 10.heightBox,
              commonTextFormField(
                hint: "Enter Total Vehicle",
                type: TextInputType.number,
                controller: totalVehicleController
              ), 10.heightBox,
              commonTextFormField(
                  hint: "Enter Total amount",
                  type: TextInputType.number,
                controller: totalAmountController
              ),
20.heightBox,
              // SizedBox(height: context.screenHeight*0.1,),
              SwipeableButtonView(
                isFinished: _isFinished,
                onFinish: () async {
                  calculateZakat();
                  print(ownerNameController.text);


                  // await Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => CalculateScreen()));
                  setState(() {
                    _isFinished = false;
                  });
                },
                onWaitingProcess: () {
                  // calculate_Zakat();
                  Future.delayed(const Duration(seconds: 1), () {
                    setState(() {
                      _isFinished = true;
                    });
                  });
                },
                activeColor: primary,
                buttonWidget: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey.shade400,
                ),
                buttonText: 'Calculate',),
            ],
          ).box.white.margin(const EdgeInsets.all(20)).rounded.shadowSm.padding(const EdgeInsets.symmetric(horizontal: 20,vertical: 40)).make()
            ],
          ),
        ),
      ),

    );
  }
}
