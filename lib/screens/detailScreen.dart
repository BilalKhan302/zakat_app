import 'dart:async';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../const/common.dart';
import '../services/services.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key, required this.title}) : super(key: key);
  String? title;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  //stream
  StreamController<List<VehicleInstallments>>
      _vehicleInstallmentsStreamController =
      StreamController<List<VehicleInstallments>>();
  void initState() {
    super.initState();
    _detailsInstallment();
  }
  void _detailsInstallment() {
    final dbHelper = DatabaseHelper.instance;
    dbHelper.vehicleInstallmentsDetailsList().listen((installmentsList) {
      _vehicleInstallmentsStreamController.add(installmentsList
          .map((map) => VehicleInstallments.fromMap(map))
          .toList());

      // Update your logic here using the `vehicleInstallments` list
    });
  }
  @override
  void dispose() {
    _vehicleInstallmentsStreamController.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey.shade400,
            )),
        centerTitle: true,
        title: Text(
          widget.title.toString(),
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade400),
        ),
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh,color: Colors.grey.shade400,),
            onPressed: _detailsInstallment,
          ),
        ],
      ),
      body: StreamBuilder<List<VehicleInstallments>>(
        stream: _vehicleInstallmentsStreamController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No vehicles found.'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  "Monthly Installments".text.size(30).color(Colors.black45).make(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      VehicleInstallments vehicleInstallments = snapshot.data![index];
                      return Column(
                        children: [
                          Table(
                            border: TableBorder.all(), // Add borders to the table
                            defaultColumnWidth: FixedColumnWidth(120.0), // Set a fixed width for columns
                            children: [
                              _buildTableRow(['Month', 'Installment']), // Create the header row
                              _buildTableRow(['January', vehicleInstallments.janInstallment.toString()]), // Create a data row for January
                              _buildTableRow(['February', vehicleInstallments.febInstallment.toString()]), // Create a data row for February
                              // Add data rows for the remaining months...
                              _buildTableRow(['March', vehicleInstallments.marInstallment.toString()]),
                              _buildTableRow(['April', vehicleInstallments.aprInstallment.toString()]),
                              _buildTableRow(['May', vehicleInstallments.mayInstallment.toString()]),
                              _buildTableRow(['June', vehicleInstallments.junInstallment.toString()]),
                              _buildTableRow(['July', vehicleInstallments.julInstallment.toString()]),
                              _buildTableRow(['August', vehicleInstallments.augInstallment.toString()]),
                              _buildTableRow(['September', vehicleInstallments.sepInstallment.toString()]),
                              _buildTableRow(['October', vehicleInstallments.octInstallment.toString()]),
                              _buildTableRow(['November', vehicleInstallments.novInstallment.toString()]),
                              _buildTableRow(['December', vehicleInstallments.decInstallment.toString()]),
                            ],
                          ),
                        ],
                      );
                    },
                  ).box.white.margin(EdgeInsets.all(30)).padding(EdgeInsets.all(20)).roundedSM.make(),

                ],
              ),
            );
          }
        },
      ),
    );
  }
  TableRow _buildTableRow(List<String> data) {
    return TableRow(
      children: data.map((cell) => TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(cell),
        ),
      )).toList(),
    );
  }
}
