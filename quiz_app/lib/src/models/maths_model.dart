class Maths {
  String? question;
  List<String>? options;
  String? correctOption;

  Maths({
    this.question,
    this.options,
    this.correctOption,
  });

  Maths.fromJson(Map<String, dynamic> json) {
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

class MathsModel {
  List<Maths>? maths;

  MathsModel({this.maths});

  MathsModel.fromJson(Map<String, dynamic> json) {
    if (json['Maths'] != null) {
      maths = <Maths>[];
      json['Maths'].forEach((v) {
        maths!.add(Maths.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (maths != null) {
      data['Maths'] = maths!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
