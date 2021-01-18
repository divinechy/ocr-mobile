import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/landingSafeArea.dart';


class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget imagecarousel = new Container(
      height: MediaQuery.of(context).size.height / 2,
      color: Colors.white,
      child: Carousel(
          images: [
            Image.asset(
              "images/slide1.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/slide2.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/slide3.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/slide4.jpg",
              fit: BoxFit.cover,
            ),
          ],
          animationCurve: Curves.bounceOut,
          animationDuration: Duration(milliseconds: 1000),
          indicatorBgPadding: 0.4,
          dotSize: 7.0,
          dotIncreasedColor: Colors.white),
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color(0xff05a081),
        statusBarIconBrightness: Brightness.light,
      ),
    );
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LandingSafeArea(imagecarousel: imagecarousel),
      ),
    );
  }
}

