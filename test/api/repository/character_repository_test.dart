import 'package:app_rick_and_morty_flutter/src/api/model/response.dart';
import 'package:app_rick_and_morty_flutter/src/api/repository/character_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../utils/mocks/mocks.mocks.dart';

void main() {
  final service = MockHttpClient();

  CharacterRepository subject() {
    return CharacterRepository(service);
  }

  group('.getCharacters', () {
    group('on success from remote', () {
      late Response? result;

      setUpAll(() async {
        when(service.get(any)).thenAnswer(
          (_) async => http.Response(
            '{"info": {"count": 826,"pages": 42,"next": "https://rickandmortyapi.com/api/character/?page=2","prev": null},"results":[]',
            200,
          ),
        );

        result = await subject().getCharacters();
      });

      test('it returns a success', () {
        expect(result, isA<Response>());
      });
    });
  });
}
