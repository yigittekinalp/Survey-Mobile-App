import 'package:flutter/material.dart';
import 'package:survey/class/answer.dart';
import 'package:survey/class/form_controller_class.dart';
import 'package:survey/widget/form_controller_detail.dart';

class FormController extends StatefulWidget {
  @override
  _FormControllerState createState() => _FormControllerState();
}

class _FormControllerState extends State<FormController> {
  List<dynamic> feedbackItems = List<dynamic>();
  List<dynamic> scores = List<dynamic>();
  List<dynamic> company = List<dynamic>();
  List<dynamic> items = List<dynamic>();
  TextEditingController editingController = TextEditingController();
  List<dynamic> section = List<dynamic>();
  List<Answer> answer = List<Answer>();
  List<dynamic> len;

  @override
  void initState() {
    super.initState();

    MyFormController().getFeedbackList().then((feedbackItems) {
      setState(() {
        this.feedbackItems = feedbackItems;
        len = feedbackItems.first as List;
      });
    });
    MyFormController().getAnswer().then((value) {
      setState(() {
        this.answer = value;
      });
    });
    MyFormController().getScores().then((value) {
      setState(() {
        this.scores = value;
      });
    });
    MyFormController().getCompany().then((value) {
      setState(() {
        this.company = value[0];
        items.addAll(company);
      });
    });
    MyFormController().getSection().then((value) {
      setState(() {
        this.section = value[0];
      });
    });
  }

  void filterSearchResults(String query) {
    List<dynamic> dummySearchList = List<dynamic>();
    dummySearchList.addAll(company);
    if (query.isNotEmpty) {
      List<dynamic> dummyListData = List<dynamic>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(company);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Şirketler"),
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        List<dynamic> list = List<dynamic>();
                        list.addAll(
                            [feedbackItems[index], answer, scores, section]);
                        Navigator.of(context).pushNamed(
                            FormControllerDetail.routeName,
                            arguments: list);
                      },
                      child: Container(
                        height: 100,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ListTile(
                                  leading: Icon(
                                    Icons.perm_identity,
                                    size: 30,
                                  ),
                                  title: Text(
                                    items[index],
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
