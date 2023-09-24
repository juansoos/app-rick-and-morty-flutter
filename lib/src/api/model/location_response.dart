import 'package:app_rick_and_morty_flutter/src/api/model/info.dart';
import 'package:app_rick_and_morty_flutter/src/api/model/location.dart';

class LocationResponse {
  Info? info;
  List<Location>? results;

  LocationResponse({this.info, this.results});

  LocationResponse.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    if (json['results'] != null) {
      results = <Location>[];
      json['results'].forEach((v) {
        results!.add(Location.fromJson(v));
      });
    }
  }
}
