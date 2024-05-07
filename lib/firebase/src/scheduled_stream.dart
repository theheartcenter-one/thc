import 'package:flutter/material.dart';
import 'package:thc/firebase/firebase.dart';

@immutable
class ScheduledStream {
  const ScheduledStream({
    required this.title,
    required this.directorId,
    required this.startTime,
    this.duration = const Duration(minutes: 45),
  });

  factory ScheduledStream.fromJson(Json json) {
    return ScheduledStream(
      title: json['title'],
      directorId: json['directorId'],
      startTime: json['startTime'],
      duration: json['duration'],
    );
  }

  final String title;
  final String directorId;
  final DateTime startTime;
  final Duration duration;

  Json get json => {
        'title': title,
        'directorId': directorId,
        'startTime': startTime,
        'duration': duration,
      };
}
