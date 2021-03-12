import 'package:flutter/material.dart';
import 'package:survey/class/answer.dart';
import 'package:survey/class/form_controller_class.dart';
import 'package:survey/widget/graph.dart';
import 'package:survey/widget/skor_detail.dart';
import 'package:http/http.dart' as http;
import 'package:expandable/expandable.dart';

class FormControllerDetail extends StatelessWidget {
  static const routeName = '/formcontroller-detail';

  List<int> sScore = List.filled(7, 0);
  List<int> weights = List.filled(7, 0);
  List<dynamic> sendList = List<dynamic>();

  Widget section(String text, List<dynamic> question, List<dynamic> answer,
      List<dynamic> scores, List<dynamic> sections) {
    return Column(children: [
      for (var i = 1; i < (sections.length * 3) - 2; i++)
        Column(
          children: [
            Row(
              children: <Widget>[
                Icon(Icons.question_answer),
                Text(' Soru ${(i / 3).ceil()}: '),
                Expanded(
                  child: question[i - 1] != ''
                      ? checkQuestion(question[i - 1], answer, scores,
                          (i / 3).ceil(), sections[0])
                      : Text('Boş bırakılmış'),
                ),
              ],
            ),
            Divider(
              color: Colors.black54,
            )
          ],
        ),
    ]);
  }

  ex1(String text, List<dynamic> question, List<dynamic> answer,
      List<dynamic> scores, List<dynamic> sections) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(10),
            child: section(text, question, answer, scores, sections)),
      ],
    );
  }

  Widget outputText(String text, List<dynamic> question, List<dynamic> answer,
      List<dynamic> scores, List<dynamic> sections) {
    return ExpandableNotifier(
      child: Container(
        width: double.infinity,
        child: ScrollOnExpand(
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            child: Column(
              children: [
                ExpandablePanel(
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        text,
                      )),
                  expanded: ex1(text, question, answer, scores, sections),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  calSum(int weight, int score, int counter) {
    sScore[counter - 1] += score;
    weights[counter - 1] += weight;
  }

  Widget checkQuestion(String question, List<Answer> answers,
      List<dynamic> scores, int q, int counter) {
    if (question == 'Kapsam Dışı') {
      return Text(answers.first.a1 + " puan");
    } else if (question == 'Mevcut Değil') {
      calSum(scores[counter - 1][q - 1],
          int.parse(answers.first.a2) * (scores[counter - 1][q - 1]), counter);
      return Text(answers.first.a2 + " puan");
    } else if (question == 'Var ama Yeterli Değil') {
      calSum(scores[counter - 1][q - 1],
          int.parse(answers.first.a3) * (scores[counter - 1][q - 1]), counter);
      return Text(answers.first.a3 + " puan");
    } else if (question ==
        'Var, Yeterli ama İşletmenin Tamamında Uygulanmıyor') {
      calSum(scores[counter - 1][q - 1],
          int.parse(answers.first.a4) * (scores[counter - 1][q - 1]), counter);
      return Text(answers.first.a4 + " puan");
    } else if (question == 'Var, Yeterli ve İşletmenin Tamamında Uygulanıyor') {
      calSum(scores[counter - 1][q - 1],
          int.parse(answers.first.a5) * (scores[counter - 1][q - 1]), counter);
      return Text(answers.first.a5 + " puan");
    } else if (question ==
        'Var, Yeterli, Tüm İşletmede Uygulanıyor ve Protokolün Ötesinde') {
      calSum(scores[counter - 1][q - 1],
          int.parse(answers.first.a6) * (scores[counter - 1][q - 1]), counter);
      return Text(answers.first.a6 + " puan");
    } else {
      if (question.startsWith('https://')) {
        //return Image.network(
        // "https://questionpro.blob.core.windows.net/web/questionpro/userimages/2994659/3764517/7503990/80744816/73751336-80744816-S1Q2-Siperlik-Kullanm.png?sig=A%2Fnji5Z64hAssOIlKRlrkHCDyRzu%2B4HwuQFPNva5hSI%3D&se=2030-07-20T01%3A41%3A45Z&sv=2018-03-28&sp=rd&sr=b");
        return Text("resim");
      } else
        return Text(question);
    }
  }

  Widget sectionCheck(List<dynamic> question, List<dynamic> answer,
      List<dynamic> scores, List<dynamic> sections) {
    return Column(
      children: [
        for (int i = 0; i < sections.length; i++)
          outputText(
            'Bölüm ${i + 1}:',
            question[i],
            answer,
            scores,
            sections[i],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var list = ModalRoute.of(context).settings.arguments as List;
    var question = list[0];
    var answer = list[1];
    var scores = list[2];
    var sections = list[3];
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            sectionCheck(question, answer, scores, sections),
            SizedBox(
              height: 10,
            ),
            ButtonTheme(
              minWidth: 290,
              child: FlatButton.icon(
                  onPressed: () {
                    sendList.addAll([sScore, weights]);
                    Navigator.of(context)
                        .pushNamed(ScoreDetail.routeName, arguments: sendList);
                  },
                  color: Colors.yellowAccent,
                  icon: Icon(Icons.grade),
                  label: Text('Bölüm ve Toplam Skor Görüntüleme')),
            ),
            ButtonTheme(
              minWidth: 290,
              child: FlatButton.icon(
                  onPressed: () {
                    sendList.addAll([sScore, weights]);
                    Navigator.of(context)
                        .pushNamed(GraphWidget.routeName, arguments: sendList);
                  },
                  color: Colors.yellowAccent,
                  icon: Icon(Icons.insert_chart),
                  label: Text('Grafik Görüntüleme')),
            ),
          ],
        ),
      ),
    );
  }
}
