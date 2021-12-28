import 'package:cosmox/home.dart';
import 'package:cosmox/utils/BasicUtils.dart';
import 'package:cosmox/utils/globalUtils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool isInternetConnectionAvailable = true;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        animationController.reset();
        if (isInternetConnectionAvailable) {
          await openDb();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return Home();
          }));
        }
      } else if (status == AnimationStatus.forward) {
        isInternetConnectionAvailable =
            await BasicUtils.checkInternetConnection();
        if (!isInternetConnectionAvailable) {
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isInternetConnectionAvailable
          ? Container(
              color: Color(0xFF454561),
              child: Center(
                child: Lottie.asset(
                  'assets/animations/app-logo.json',
                  controller: animationController,
                  onLoaded: (onLoad) {
                    animationController.forward();
                  },
                  animate: true,
                  repeat: false,
                  fit: BoxFit.fill,
                ),
              ))
          : Container(
              color: Colors.blueAccent,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No internet connection'),
                    IconButton(
                        icon: Icon(Icons.replay_outlined),
                        onPressed: () async {
                          isInternetConnectionAvailable =
                              await BasicUtils.checkInternetConnection();
                          setState(() {});
                        })
                  ],
                ),
              ),
            ),
    );
  }
}
