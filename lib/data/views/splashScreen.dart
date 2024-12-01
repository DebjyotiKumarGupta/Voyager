import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:voyager/data/views/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds and navigate to the Explore Screen
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => ExploreScreen()); // Navigate to Explore Screen using GetX
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: height,
              width: width,
              child: Image.asset(
                "assets/images/splashScreen.png",
                fit: BoxFit.cover,
              )),
          Positioned(
            bottom: height * 0.10,
            left: width * 00.05,
            // top: height * 0.10,
            child: SvgPicture.asset("assets/images/splashText.svg"),
          ),
          Positioned(
            top: height * 0.10,
            left: MediaQuery.of(context).size.width * 0.15,
            right: MediaQuery.of(context).size.width * 0.15,
            child: SvgPicture.asset("assets/images/logo.svg"),
          )
        ],
      ),
    );
  }
}
