class English {
  String? question;
  List<String>? options;
  String? correctOption;

  English({
    this.question,
    this.options,
    this.correctOption,
  });

  English.fromJson(Map<String, dynamic> json) {
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

class EnglishModel {
  List<English>? english;

  EnglishModel({this.english});

  EnglishModel.fromJson(Map<String, dynamic> json) {
    if (json['English'] != null) {
      english = <English>[];
      json['English'].forEach((v) {
        english!.add(English.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (english != null) {
      data['English'] = english!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
