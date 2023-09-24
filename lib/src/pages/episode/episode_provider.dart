import 'package:app_rick_and_morty_flutter/src/api/model/episode.dart';
import 'package:app_rick_and_morty_flutter/src/api/model/info.dart';
import 'package:app_rick_and_morty_flutter/src/api/repository/episode_repository.dart';
import 'package:app_rick_and_morty_flutter/src/common/di/repository_module.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EpisodeProvider extends ChangeNotifier {
  EpisodeProvider(this._repository);

  final EpisodeRepository _repository;

  var isInitialLoading = true;
  var isMoreLoadingVisible = false;
  var page = 1;
  var episodes = <Episode>[];
  Info? info;

  Future<void> onInit() async {
    try {
      final response = await _repository.getEpisodes();

      episodes = response?.results ?? [];
      info = response?.info;

      if (info?.next != null) {
        page += 1;
      }

      isInitialLoading = false;

      notifyListeners();
    } catch (e) {
      isInitialLoading = false;
      episodes = [];

      notifyListeners();
    }
  }

  Future<void> fetchMoreEpisodes() async {
    try {
      isMoreLoadingVisible = true;
      notifyListeners();

      final response = await _repository.getEpisodes(page: page);

      final newEpisodes = List.of(episodes);
      newEpisodes.addAll(response?.results ?? []);

      episodes = newEpisodes;
      info = response?.info;
      isMoreLoadingVisible = false;

      if (info?.next != null) {
        page += 1;
      }

      notifyListeners();
    } catch (e) {
      isMoreLoadingVisible = false;

      notifyListeners();
    }
  }
}

final episodeProvider = ChangeNotifierProvider<EpisodeProvider>((ref) {
  return EpisodeProvider(
    RepositoryModule.episodeRepository(),
  );
});
