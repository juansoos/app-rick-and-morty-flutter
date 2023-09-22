import 'package:app_rick_and_morty_flutter/src/api/http_client.dart';
import 'package:app_rick_and_morty_flutter/src/api/repository/character_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  HttpClient,
  CharacterRepository,
])
void main() {}
