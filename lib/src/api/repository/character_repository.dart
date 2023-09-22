import 'dart:convert';
import 'package:app_rick_and_morty_flutter/src/api/http_client.dart';
import 'package:app_rick_and_morty_flutter/src/api/model/response.dart';

class CharacterRepository {
  CharacterRepository(this._service);

  final HttpClient _service;

  get convert => null;

  Future<Response?> getCharacters({int? page = 1}) async {
    try {
      final path = '/character/?page=$page';

      final response = await _service.get(path);

      return Response.fromJson(jsonDecode(response.body));
    } catch (e) {
      return null;
    }
  }
}
