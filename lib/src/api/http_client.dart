import 'dart:convert';
import 'package:http/http.dart';

class HttpClient {
  HttpClient(this._host);

  final String _host;

  Future<Response> get(String path) async {
    final url = '$_host$path';

    final response = await Client().get(Uri.parse(url));

    return response;
  }

  Future<Response> post(
    String path, {
    Object? body,
  }) async {
    final url = '$_host$path';
    final encodedBody = jsonEncode(body);

    final response = await Client().post(
      Uri.parse(url),
      body: encodedBody,
    );

    return response;
  }
}
