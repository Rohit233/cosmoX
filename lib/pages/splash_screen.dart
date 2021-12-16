import 'package:cosmox/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
    void initState() {
      animationController = AnimationController(vsync: this,duration: Duration(seconds: 6));
      animationController.addStatusListener((status) {
          if(status == AnimationStatus.completed){
            animationController.reset();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return Home();
            }));
            
          }
      });
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF454561),
        child: Center(
          child: Lottie.asset('assets/animations/app-logo.json',
          controller: animationController,
          onLoaded: (onLoad){
              animationController.forward();
          },
          animate: true,
          repeat: false,
          fit: BoxFit.fill,),
        )
      ),
    );
  }
}