class Science {
  String? question;
  List<String>? options;
  String? correctOption;

  Science({
    this.question,
    this.options,
    this.correctOption,
  });

  Science.fromJson(Map<String, dynamic> json) {
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

class ScienceModel {
  List<Science>? science;

  ScienceModel({this.science});

  ScienceModel.fromJson(Map<String, dynamic> json) {
    if (json['Science'] != null) {
      science = <Science>[];
      json['Science'].forEach((v) {
        science!.add(Science.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (science != null) {
      data['Science'] = science!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
