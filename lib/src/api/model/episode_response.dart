import 'package:app_rick_and_morty_flutter/src/api/model/episode.dart';
import 'package:app_rick_and_morty_flutter/src/api/model/info.dart';

class EpisodeResponse {
  Info? info;
  List<Episode>? results;

  EpisodeResponse({this.info, this.results});

  EpisodeResponse.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    if (json['results'] != null) {
      results = <Episode>[];
      json['results'].forEach((v) {
        results!.add(Episode.fromJson(v));
      });
    }
  }
}
