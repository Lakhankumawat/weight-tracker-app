import 'dart:convert';

WeightsModel weightsModelFromJson(Map<String, dynamic>? data) =>
    WeightsModel.fromJson(data!);

String weightsModelToJson(WeightsModel data) => json.encode(data.toJson());

class WeightsModel {
  WeightsModel({
    required this.docId,
    required this.time,
    required this.value,
  });

  final String docId;
  final int time;
  final String value;

  factory WeightsModel.fromJson(Map<String, dynamic> json) => WeightsModel(
        docId: json["docId"],
        time: json["time"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "docId": docId,
        "time": time,
        "value": value,
      };
}
