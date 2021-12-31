import 'dart:async';

import 'package:flutter/material.dart';

import 'productpage.dart';

void main() => runApp( const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
       home: SplashPage());
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late double screenHeight, screenWidth, resWidth;

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (content) => const ProductPage())));
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth * 0.85;
    } else {
      resWidth = screenWidth * 0.75;
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/hotel.png'),
                    fit: BoxFit.cover))),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("WELCOME TO",
            style: TextStyle(fontSize: resWidth * 0.1, fontWeight: FontWeight.bold),),
            Text("RENTAROOM",
            style: TextStyle(fontSize: resWidth * 0.12, fontWeight: FontWeight.bold, backgroundColor: Colors.white),),
            const CircularProgressIndicator()
          ],
        ),
      ],
    );
  }
}
