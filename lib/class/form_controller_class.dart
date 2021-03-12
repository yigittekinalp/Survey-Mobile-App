import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:survey/class/answer.dart';

class MyFormController {
  static const String url_question =
      "https://script.google.com/macros/s/AKfycbymj14aBDXsuA8C1JmcBH3Soym4nhoi8bzh4MwK2TCWKphGOc8/exec";
  static const String url_answers =
      "https://script.google.com/macros/s/AKfycbzO0IpgeXdK2OHJyfku0JusIu2Gcf8rm206ovRZBXtpyJjAtKe4/exec";
  static const String url_scores =
      "https://script.google.com/macros/s/AKfycbw2ohcREdp3SxngMqApPW6QDfju4ZuBc38KqxASUY3843dLzyY/exec";
  static const String url_company =
      "https://script.google.com/macros/s/AKfycbwTL7Kvw8qGjD-W0dFfLlRWdJsSEw01ZP6NOmgpto1p04OTRjI/exec";
  static const String url_section =
      "https://script.google.com/macros/s/AKfycbz2XeWgKaJ_r9F6b7FIdlW-DGFAIaWsxovsMAKuxnVEhmi3C8o/exec";

  Future<List<dynamic>> getFeedbackList() async {
    return await http.get(url_question).then((response) {
      var data = json.decode(response.body) as List;
      return data;
    });
  }

  Future<List<dynamic>> getScores() async {
    return await http.get(url_scores).then((response) {
      var data = json.decode(response.body) as List;
      return data;
    });
  }

  Future<List<dynamic>> getCompany() async {
    return await http.get(url_company).then((response) {
      var data = json.decode(response.body) as List;
      return data;
    });
  }

  Future<List<Answer>> getAnswer() async {
    return await http.get(url_answers).then((response) {
      var jsonFeedback = json.decode(response.body) as List;
      return jsonFeedback.map((json) => Answer.fromJson(json)).toList();
    });
  }

  Future<List<dynamic>> getSection() async {
    return await http.get(url_section).then((response) {
      var jsonFeedback = json.decode(response.body) as List;
      return jsonFeedback;
    });
  }
}
