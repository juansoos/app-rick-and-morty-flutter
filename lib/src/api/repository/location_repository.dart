import 'dart:convert';
import 'package:app_rick_and_morty_flutter/src/api/http_client.dart';
import 'package:app_rick_and_morty_flutter/src/api/model/location_response.dart';

class LocationRepository {
  LocationRepository(this._service);

  final HttpClient _service;

  Future<LocationResponse?> getLocations({int? page = 1}) async {
    try {
      final path = '/location/?page=$page';

      final response = await _service.get(path);

      return LocationResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return null;
    }
  }
}
