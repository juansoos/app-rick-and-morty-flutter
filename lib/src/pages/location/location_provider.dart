import 'package:app_rick_and_morty_flutter/src/api/model/info.dart';
import 'package:app_rick_and_morty_flutter/src/api/model/location.dart';
import 'package:app_rick_and_morty_flutter/src/api/repository/location_repository.dart';
import 'package:app_rick_and_morty_flutter/src/common/di/repository_module.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationProvider extends ChangeNotifier {
  LocationProvider(this._repository);

  final LocationRepository _repository;

  var isInitialLoading = true;
  var isMoreLoadingVisible = false;
  var hasMoreLocations = true;

  var page = 1;
  var locations = <Location>[];
  Info? info;

  Future<void> onInit() async {
    try {
      final response = await _repository.getLocations();

      locations = response?.results ?? [];
      info = response?.info;

      isInitialLoading = false;
      hasMoreLocations = info?.next != null;

      notifyListeners();
    } catch (e) {
      isInitialLoading = false;
      locations = [];

      notifyListeners();
    }
  }

  Future<void> fetchMoreLocations() async {
    try {
      if (hasMoreLocations) {
        isMoreLoadingVisible = true;
        notifyListeners();

        final nextPage = page + 1;

        final response = await _repository.getLocations(page: nextPage);

        final newLocations = List.of(locations);
        newLocations.addAll(response?.results ?? []);

        isMoreLoadingVisible = false;
        hasMoreLocations = response?.info?.next != null;

        locations = newLocations;
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

final locationProvider = ChangeNotifierProvider<LocationProvider>((ref) {
  return LocationProvider(
    RepositoryModule.locationRepository(),
  );
});
