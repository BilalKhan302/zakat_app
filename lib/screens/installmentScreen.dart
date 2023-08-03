import 'package:flutter/material.dart';
import 'package:zakat_app/const/common.dart';
import '../services/services.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
class InstallmentScreen extends StatefulWidget {
  const InstallmentScreen({Key? key}) : super(key: key);

  @override
  State<InstallmentScreen> createState() => _InstallmentScreenState();
}

class _InstallmentScreenState extends State<InstallmentScreen> {


  double zakatAmount = 0.0;
  int years = 0;
  int seletedIndex=0;
  bool _isFinished = false;
  TextEditingController idController=TextEditingController();
  TextEditingController vehicleIdRefController = TextEditingController();
  TextEditingController janInstallmentController = TextEditingController();
  TextEditingController febInstallmentController = TextEditingController();
  TextEditingController marInstallmentController = TextEditingController();
  TextEditingController aprInstallmentController = TextEditingController();
  TextEditingController mayInstallmentController = TextEditingController();
  TextEditingController junInstallmentController = TextEditingController();
  TextEditingController julInstallmentController = TextEditingController();
  TextEditingController augInstallmentController = TextEditingController();
  TextEditingController sepInstallmentController = TextEditingController();
  TextEditingController octInstallmentController = TextEditingController();
  TextEditingController novInstallmentController = TextEditingController();
  TextEditingController decInstallmentController = TextEditingController();
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  @override
  void dispose() {
    idController.dispose();
    vehicleIdRefController.dispose();
    janInstallmentController.dispose();
    febInstallmentController.dispose();
    marInstallmentController.dispose();
    aprInstallmentController.dispose();
    mayInstallmentController.dispose();
    junInstallmentController.dispose();
    julInstallmentController.dispose();
    augInstallmentController.dispose();
    sepInstallmentController.dispose();
    octInstallmentController.dispose();
    novInstallmentController.dispose();
    decInstallmentController.dispose();
    super.dispose();
  }
  Future<void> submitInstallment() async {
    // Create a VehicleInstallments object
    VehicleInstallments vehicleInstallments =  VehicleInstallments(
      id: int.parse(idController.text),
      vehicleIdRef: int.parse(vehicleIdRefController.text),
      janInstallment: double.parse(janInstallmentController.text),
      febInstallment: double.parse(febInstallmentController.text),
      marInstallment: double.parse(marInstallmentController.text),
      aprInstallment: double.parse(aprInstallmentController.text),
      mayInstallment: double.parse(mayInstallmentController.text),
      junInstallment: double.parse(junInstallmentController.text),
      julInstallment: double.parse(julInstallmentController.text),
      augInstallment: double.parse(augInstallmentController.text),
      sepInstallment: double.parse(sepInstallmentController.text),
      octInstallment: double.parse(octInstallmentController.text),
      novInstallment: double.parse(novInstallmentController.text),
      decInstallment: double.parse(decInstallmentController.text),

    );
    final vehicleInstallmentsMap = vehicleInstallments.toMap();
    await dbHelper.insertVehicleInstallmentsDetails(vehicleInstallmentsMap);

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
                child: Center(child: Text("InstallmentScreen",style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade400
                ),)),
              ).box.white.size(context.screenWidth, 150).color(primary).bottomRightRounded(value: 60).make(),
              20.heightBox,
              Column(
                children: [
                  // commonTextFormField(
                  //     hint: "Enter id",
                  //     type: TextInputType.number,
                  //     controller: idController
                  // ),
                  // 10.heightBox,
                  commonTextFormField(
                      hint: "Enter Id",
                      type: TextInputType.number,
                      controller: idController
                  ),
                  10.heightBox,
                  commonTextFormField(
                      hint: "Enter vehicleId",
                      type: TextInputType.number,
                      controller: vehicleIdRefController
                  ),
                  10.heightBox,
                  commonTextFormField(
                      hint: "Jan installment",
                      type: TextInputType.number,
                      controller: janInstallmentController
                  ),
                  10.heightBox,
                  commonTextFormField(
                      hint: "Feb installment",
                      type: TextInputType.number,
                      controller: febInstallmentController
                  ),
                  10.heightBox,
                  commonTextFormField(
                      hint: "March installment",
                      type: TextInputType.number,
                      controller: marInstallmentController
                  ), 10.heightBox,
                  commonTextFormField(
                      hint: "Apr installment",
                      type: TextInputType.number,
                      controller: aprInstallmentController
                  ), 10.heightBox,
                  commonTextFormField(
                      hint: "May installment",
                      type: TextInputType.number,
                      controller: mayInstallmentController
                  ),
                  10.heightBox,
                  commonTextFormField(
                      hint: "Jun installment",
                      type: TextInputType.number,
                      controller: junInstallmentController
                  ),
                  10.heightBox,
                  commonTextFormField(
                      hint: "Jul installment",
                      type: TextInputType.number,
                      controller: julInstallmentController
                  ),
                  10.heightBox,
                  commonTextFormField(
                      hint: "Aug installment",
                      type: TextInputType.number,
                      controller: augInstallmentController
                  ),
                  10.heightBox,
                  commonTextFormField(
                      hint: "Sep installment",
                      type: TextInputType.number,
                      controller: sepInstallmentController
                  ),
                  10.heightBox,
                  commonTextFormField(
                      hint: "Oct installment",
                      type: TextInputType.number,
                      controller: octInstallmentController
                  ),
                  10.heightBox,
                  commonTextFormField(
                      hint: "Nov installment",
                      type: TextInputType.number,
                      controller: novInstallmentController
                  ),
                  10.heightBox,
                  commonTextFormField(
                      hint: "Dec installment",
                      type: TextInputType.number,
                      controller: decInstallmentController
                  ),
                  20.heightBox,
                  // SizedBox(height: context.screenHeight*0.1,),
                  SwipeableButtonView(
                    isFinished: _isFinished,
                    onFinish: () async {
                      submitInstallment();
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
                    buttonText: 'Submit Installments',),
                ],
              ).box.white.margin(const EdgeInsets.all(20)).rounded.shadowSm.padding(const EdgeInsets.symmetric(horizontal: 20,vertical: 40)).make()
            ],
          ),
        ),
      ),

    );
  }
}
