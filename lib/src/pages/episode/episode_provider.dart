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
  var hasMoreEpisodes = true;

  var page = 1;
  var episodes = <Episode>[];
  Info? info;

  Future<void> onInit() async {
    try {
      final response = await _repository.getEpisodes();

      episodes = response?.results ?? [];
      info = response?.info;

      isInitialLoading = false;
      hasMoreEpisodes = info?.next != null;

      notifyListeners();
    } catch (e) {
      isInitialLoading = false;
      episodes = [];

      notifyListeners();
    }
  }

  Future<void> fetchMoreEpisodes() async {
    try {
      if (hasMoreEpisodes) {
        isMoreLoadingVisible = true;
        notifyListeners();

        final nextPage = page + 1;

        final response = await _repository.getEpisodes(page: nextPage);

        final newEpisodes = List.of(episodes);
        newEpisodes.addAll(response?.results ?? []);

        isMoreLoadingVisible = false;
        hasMoreEpisodes = response?.info?.next != null;

        episodes = newEpisodes;
        info = response?.info;
        page = nextPage;

        notifyListeners();
      }
    } catch (e) {
      isMoreLoadingVisible = false;

      notifyListeners();
    }
  }

  void onSearch(String query) {
    final List<Episode> initialEpisodeList = List.of(episodes);

    if (query.isNotEmpty) {
      final List<Episode> episodesFiltered = [];

      for (var item in initialEpisodeList) {
        final textToCompareTo = item.name!.toLowerCase();

        if (textToCompareTo.contains(query.toLowerCase())) {
          episodesFiltered.add(item);
        }
      }

      episodes = episodesFiltered;

      notifyListeners();
    } else {
      episodes = initialEpisodeList;

      notifyListeners();
    }
  }
}

final episodeProvider = ChangeNotifierProvider<EpisodeProvider>((ref) {
  return EpisodeProvider(
    RepositoryModule.episodeRepository(),
  );
});
