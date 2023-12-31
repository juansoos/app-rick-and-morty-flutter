import 'package:app_rick_and_morty_flutter/src/api/repository/character_repository.dart';
import 'package:app_rick_and_morty_flutter/src/api/repository/episode_repository.dart';
import 'package:app_rick_and_morty_flutter/src/api/repository/location_repository.dart';
import 'package:app_rick_and_morty_flutter/src/common/di/http_client_module.dart';

abstract class RepositoryModule {
  static CharacterRepository characterRepository() {
    return CharacterRepository(
      HttpClientModule.httpClient(),
    );
  }

  static LocationRepository locationRepository() {
    return LocationRepository(
      HttpClientModule.httpClient(),
    );
  }

  static EpisodeRepository episodeRepository() {
    return EpisodeRepository(
      HttpClientModule.httpClient(),
    );
  }
}
