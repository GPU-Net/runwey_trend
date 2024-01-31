
class QuestionsModel {
  String? status;
  int? statusCode;
  List<Question>? data;

  QuestionsModel({
    this.status,
    this.statusCode,
    this.data,
  });

  factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
    status: json["status"],
    statusCode: json["statusCode"],
    data: json["data"] == null ? [] : List<Question>.from(json["data"]!.map((x) => Question.fromJson(x))),
  );


}

class Question {
  String? id;
  String? question;

  Question({
    this.id,
    this.question,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["_id"],
    question: json["question"],
  );


}
