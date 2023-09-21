import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeProvider extends ChangeNotifier {
  var tabPosition = 0;

  void onItemTapped(int index) {
    tabPosition = index;
    notifyListeners();
  }
}

final homeProvider = ChangeNotifierProvider<HomeProvider>((ref) {
  return HomeProvider();
});
