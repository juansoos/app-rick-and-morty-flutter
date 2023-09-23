import 'package:app_rick_and_morty_flutter/src/api/http_client.dart';

abstract class HttpClientModule {
  static HttpClient httpClient() {
    return HttpClient("https://rickandmortyapi.com/api");
  }
}
