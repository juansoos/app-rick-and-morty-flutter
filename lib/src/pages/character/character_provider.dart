import 'package:app_rick_and_morty_flutter/src/api/model/character.dart';
import 'package:app_rick_and_morty_flutter/src/api/model/info.dart';
import 'package:app_rick_and_morty_flutter/src/api/repository/character_repository.dart';
import 'package:app_rick_and_morty_flutter/src/common/di/repository_module.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterProvider extends ChangeNotifier {
  CharacterProvider(this._repository);

  final CharacterRepository _repository;

  var isInitialLoading = true;
  var isMoreLoadingVisible = false;
  var hasMoreCharacters = true;

  var page = 1;
  var characters = <Character>[];
  Info? info;

  Future<void> onInit() async {
    try {
      final response = await _repository.getCharacters();

      characters = response?.results ?? [];
      info = response?.info;

      isInitialLoading = false;
      hasMoreCharacters = info?.next != null;

      notifyListeners();
    } catch (e) {
      isInitialLoading = false;
      characters = [];

      notifyListeners();
    }
  }

  Future<void> fetchMoreCharacters() async {
    try {
      if (hasMoreCharacters) {
        final nextPage = page + 1;

        isMoreLoadingVisible = true;
        notifyListeners();

        final response = await _repository.getCharacters(page: nextPage);

        final newCharacters = List.of(characters);
        newCharacters.addAll(response?.results ?? []);

        isMoreLoadingVisible = false;
        hasMoreCharacters = response?.info?.next != null;

        characters = newCharacters;
        info = response?.info;
        page = nextPage;

        notifyListeners();
      }
    } catch (e) {
      isMoreLoadingVisible = false;

      notifyListeners();
    }
  }
}

final characterProvider = ChangeNotifierProvider<CharacterProvider>((ref) {
  return CharacterProvider(
    RepositoryModule.characterRepository(),
  );
});
