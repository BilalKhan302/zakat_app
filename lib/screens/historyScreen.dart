import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zakat_app/const/common.dart';
import 'package:velocity_x/velocity_x.dart';
import '../services/services.dart';
import 'detailScreen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  StreamController<List<Vehicle>> _vehiclesStreamController =
  StreamController<List<Vehicle>>();

  @override
  void initState() {
    super.initState();
    _subscribeToVehicles();
  }

  void _subscribeToVehicles() {
    final dbHelper = DatabaseHelper.instance;
    dbHelper.getAllVehicles().listen((vehicles) {
      _vehiclesStreamController.add(
        vehicles.map((vehicleData) => Vehicle.fromMap(vehicleData)).toList(),
      );
    });
  }


  @override
  void dispose() {
    _vehiclesStreamController.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text("History",style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade400
        ),),
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
            onPressed: _subscribeToVehicles,
          ),
        ],
      ),
      body: StreamBuilder<List<Vehicle>>(
        stream: _vehiclesStreamController.stream,
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
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Vehicle vehicle = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: Colors.grey.shade400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "VehicleId: ${vehicle.vehicleId}".text.size(24).fontWeight(FontWeight.w400).color(Colors.grey.shade400).make(),
                        ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(title: vehicle.registrationNumber,)));
                          },
                          title: Text('Owner Name: ${vehicle.ownerName}'),
                          subtitle: Text('Vehicle Registration Number: ${vehicle.registrationNumber}'),
                          // Add more ListTile properties as needed
                        ),
                      ],
                    ).box.white.margin(EdgeInsets.all(10)).padding(EdgeInsets.all(20)).roundedSM.make()
                  ),
                );
              },
            ).box.white.margin(EdgeInsets.all(20)).padding(EdgeInsets.all(20)).roundedSM.make();
          }
        },
      ),
    );
  }
}
