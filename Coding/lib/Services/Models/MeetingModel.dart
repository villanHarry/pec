// To parse this JSON data, do
//
//     final meetingModel = meetingModelFromJson(jsonString);

import 'dart:convert';

MeetingModel meetingModelFromJson(String str) =>
    MeetingModel.fromJson(json.decode(str));

String meetingModelToJson(MeetingModel data) => json.encode(data.toJson());

class MeetingModel {
  MeetingModel({
    required this.message,
    required this.meeting,
  });

  String message;
  Meeting meeting;

  factory MeetingModel.fromJson(Map<String, dynamic> json) => MeetingModel(
        message: json["message"],
        meeting: Meeting.fromJson(json["meeting"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "meeting": meeting.toJson(),
      };
}

class Meeting {
  Meeting({
    required this.meetingId,
  });

  String meetingId;

  factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
        meetingId: json["MeetingID"],
      );

  Map<String, dynamic> toJson() => {
        "MeetingID": meetingId,
      };
}
