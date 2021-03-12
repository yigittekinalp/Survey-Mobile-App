import 'package:flutter/material.dart';

class ScoreDetail extends StatelessWidget {
  static const routeName = '/score-detail';
  double totalScore = 0;

  Widget showScore(String text, double score) {
    totalScore += score;
    return Align(
        alignment: Alignment.topLeft,
        child: Text(text + score.toStringAsFixed(2)));
  }

  Widget clear() {
    this.totalScore = 0;
    return SizedBox(
      height: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    var list = ModalRoute.of(context).settings.arguments as List;
    var scores = list[0];
    var sum = list[1];
    return Scaffold(
      appBar: AppBar(
        title: Text('Skor Değerlendirme'),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                showScore("Bölüm 1: ", (scores[0] / sum[0])),
                showScore("Bölüm 2: ", (scores[1] / sum[1])),
                showScore("Bölüm 3: ", (scores[2] / sum[2])),
                showScore("Bölüm 4: ", (scores[3] / sum[3])),
                showScore("Bölüm 5: ", (scores[4] / sum[4])),
                showScore("Bölüm 6: ", (scores[5] / sum[5])),
                showScore("Bölüm 7: ", (scores[6] / sum[6])),
                Text("Toplam Skor: " + totalScore.toStringAsFixed(2)),
                clear(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
