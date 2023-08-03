import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'calculateScreen.dart';
import 'homeScreen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: Center(
        child: Lottie.asset('assets/zakat.json',
            height: 200,
            width: 250,
            fit: BoxFit.cover
        ),
      ),
    );
  }
}
