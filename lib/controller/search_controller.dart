import 'package:flutter/foundation.dart';

class SearchControllerProvider extends ChangeNotifier {
  bool isSearching = false;
  void toggleSearch() {
    isSearching = !isSearching;
    notifyListeners();
  }
}
