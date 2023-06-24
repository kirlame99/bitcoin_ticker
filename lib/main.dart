import 'package:flutter/material.dart';
import 'price_screen.dart';
import 'package:device_preview/device_preview.dart';

void main() => runApp(
  //DevicePreview(builder: (context)=> MyApp())
  MyApp()
  );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //locale: DevicePreview.locale(context),
      //builder: DevicePreview.appBuilder,
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.white),
      home: PriceScreen(),
    );
  }
}
