import 'package:flutter/material.dart';
import 'package:multi_charts/multi_charts.dart';

class GraphWidget extends StatelessWidget {
  static const routeName = '/graph';
  printVal(String bolum, double a) {
    return "$bolum \n${a.toStringAsFixed(2)}";
  }

  @override
  Widget build(BuildContext context) {
    var list = ModalRoute.of(context).settings.arguments as List;
    var scores = list[0];
    var sum = list[1];
    return Scaffold(
      appBar: AppBar(
        title: Text('Grafik'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          child: RadarChart(
            values: [
              (scores[0] / sum[0]),
              (scores[1] / sum[1]),
              (scores[2] / sum[2]),
              (scores[3] / sum[3]),
              (scores[4] / sum[4]),
              (scores[5] / sum[5]),
              (scores[6] / sum[6]),
            ],
            labels: [
              printVal("Bölüm 1", (scores[0] / sum[0])),
              printVal("Bölüm 2", (scores[1] / sum[1])),
              printVal("Bölüm 3", (scores[2] / sum[2])),
              printVal("Bölüm 4", (scores[3] / sum[3])),
              printVal("Bölüm 5", (scores[4] / sum[4])),
              printVal("Bölüm 6", (scores[5] / sum[5])),
              printVal("Bölüm 7", (scores[6] / sum[6])),
            ],
            maxValue: 5,
            fillColor: Colors.red,
          ),
        ),
      ),
    );
  }
}
