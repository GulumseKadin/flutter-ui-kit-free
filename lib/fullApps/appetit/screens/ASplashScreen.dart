import 'package:flutter/material.dart';
import 'AWalkThroughScreen.dart';
import 'package:prokit_flutter/main/utils/AppConstant.dart';
import 'package:prokit_flutter/fullApps/appetit/utils/ACommon.dart';

class ASplashScreen extends StatefulWidget {
  const ASplashScreen({Key? key}) : super(key: key);

  @override
  _ASplashScreenState createState() => _ASplashScreenState();
}

class _ASplashScreenState extends State<ASplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AWalkThroughScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: Text('Appetit', style: TextStyle(fontSize: 45))),
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              'images/appetit/pizza2.png',
              fit: BoxFit.cover,
              height: 120,
              width: 120,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              'images/appetit/pizza1.png',
              fit: BoxFit.cover,
              height: 130,
              width: 130,
            ),
          ),
        ],
      ),
    );
  }
}
