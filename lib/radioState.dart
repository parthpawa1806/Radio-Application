import 'package:flutter/foundation.dart';

class RadioState extends ChangeNotifier {
  bool _isPlaying = false;
  double _waveAmplitude = 0.2;

  bool get isPlaying => _isPlaying;
  double get waveAmplitude => _waveAmplitude;

  void setPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }
}
