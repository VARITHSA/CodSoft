class History {
  String? question;
  List<String>? options;
  String? correctOption;

  History({
    this.question,
    this.options,
    this.correctOption,
  });

  History.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    options = json['options'].cast<String>();
    correctOption = json['correct_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['options'] = options;
    data['correct_answer'] = correctOption;
    return data;
  }
}

class HistoryModel {
  List<History>? history;

  HistoryModel({this.history});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['History'] != null) {
      history = <History>[];
      json['History'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (history != null) {
      data['History'] = history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
