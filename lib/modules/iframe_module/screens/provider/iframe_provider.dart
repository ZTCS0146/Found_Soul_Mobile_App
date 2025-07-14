import 'package:flutter/foundation.dart';

class WebViewProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool _isPlayListLoading = true;
  bool get isLoading => _isLoading;
  bool get isPlayListLoading => _isPlayListLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setPlayListLoading(bool value) {
    _isPlayListLoading = value;
    notifyListeners();
  }
}
