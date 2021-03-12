import 'package:flutter/material.dart';
import 'package:survey/widget/form_controller.dart';
import 'package:survey/widget/form_controller_detail.dart';
import 'package:survey/widget/graph.dart';
import 'package:survey/widget/skor_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (ctx) => FormController(),
        FormControllerDetail.routeName: (ctx) => FormControllerDetail(),
        ScoreDetail.routeName: (ctx) => ScoreDetail(),
        GraphWidget.routeName: (ctx) => GraphWidget(),
      },
    );
  }
}
