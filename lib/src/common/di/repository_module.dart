import 'package:app_rick_and_morty_flutter/src/api/repository/character_repository.dart';
import 'package:app_rick_and_morty_flutter/src/common/di/http_client_module.dart';

abstract class RepositoryModule {
  static CharacterRepository characterRepository() {
    return CharacterRepository(
      HttpClientModule.httpClient(),
    );
  }
}
