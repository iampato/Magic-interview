// ignore_for_file: public_member_api_docs, sort_constructors_first

class WorkoutModel {
  String id;
  String type;
  DateTime dateCreatedAt;
  DateTime dateUpdatedAt;
  int noOfSets;
  int noOfReps;
  double weight;
  String userId;

  WorkoutModel({
    required this.id,
    required this.type,
    required this.dateCreatedAt,
    required this.dateUpdatedAt,
    required this.noOfSets,
    required this.noOfReps,
    required this.weight,
    required this.userId,
  });

  factory WorkoutModel.fromJson(Map<String, dynamic> json) => WorkoutModel(
        id: json["id"],
        type: json["type"],
        dateCreatedAt: DateTime.parse(json["dateCreatedAt"]),
        dateUpdatedAt: DateTime.parse(json["dateUpdatedAt"]),
        noOfSets: json["noOfSets"],
        noOfReps: json["noOfReps"],
        weight: json["weight"].toDouble(),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "dateCreatedAt": dateCreatedAt.toIso8601String(),
        "dateUpdatedAt": dateUpdatedAt.toIso8601String(),
        "noOfSets": noOfSets,
        "noOfReps": noOfReps,
        "weight": weight,
        "userId": userId,
      };
}
