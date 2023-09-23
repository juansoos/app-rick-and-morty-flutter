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
  List<Character>? characters;
  Info? info;

  Future<void> onInit() async {
    try {
      final response = await _repository.getCharacters();

      characters = response?.results;
      info = response?.info;
      isInitialLoading = false;

      notifyListeners();
    } catch (e) {
      isInitialLoading = false;
      characters = [];

      notifyListeners();
    }
  }
}

final characterProvider = ChangeNotifierProvider<CharacterProvider>((ref) {
  return CharacterProvider(
    RepositoryModule.characterRepository(),
  );
});
