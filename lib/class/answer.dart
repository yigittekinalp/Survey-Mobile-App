class Answer {
  String a1;
  String a2;
  String a3;
  String a4;
  String a5;
  String a6;

  Answer(this.a1, this.a2, this.a3, this.a4, this.a5, this.a6);

  factory Answer.fromJson(dynamic json) {
    return Answer(
        "${json['Kapsam Dışı']}",
        "${json['Mevcut Değil']}",
        "${json['Var ama Yeterli Değil']}",
        "${json['Var, Yeterli ama İşletmenin Tamamında Uygulanmıyor']}",
        "${json['Var, Yeterli ve İşletmenin Tamamında Uygulanıyor']}",
        "${json['Var, Yeterli, Tüm İşletmede Uygulanıyor ve Protokolün Ötesinde']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'Kapsam Dışı': a1,
        'Mevcut Değil': a2,
        'Var ama Yeterli Değil': a3,
        'Var, Yeterli ama İşletmenin Tamamında Uygulanmıyor': a4,
        'Var, Yeterli ve İşletmenin Tamamında Uygulanıyor': a5,
        'Var, Yeterli, Tüm İşletmede Uygulanıyor ve Protokolün Ötesinde': a6,
      };
}
