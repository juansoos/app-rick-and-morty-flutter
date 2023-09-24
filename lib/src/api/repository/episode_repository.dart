import 'dart:convert';
import 'package:app_rick_and_morty_flutter/src/api/http_client.dart';
import 'package:app_rick_and_morty_flutter/src/api/model/episode_response.dart';

class EpisodeRepository {
  EpisodeRepository(this._service);

  final HttpClient _service;

  Future<EpisodeResponse?> getEpisodes({int? page = 1}) async {
    try {
      final path = '/episode/?page=$page';

      final response = await _service.get(path);

      return EpisodeResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return null;
    }
  }
}
