import 'package:flutter/foundation.dart';

class EventProvider extends ChangeNotifier {
  bool _isEventLoading = true;

  bool get isEventLoading => _isEventLoading;

  void setLoading(bool value) {
    _isEventLoading = value;
    notifyListeners();
  }
}
