import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import '../data/game_assets.dart';

class AudioController extends ChangeNotifier {
  final AudioPlayer _musicPlayer = AudioPlayer();
  String? _currentTrack;
  bool _isOneShot = false;

  AudioController() {
    _musicPlayer.setVolume(0.75);
  }

  Future<void> playLogin() => playLoop(GameAssets.loginMusic);

  Future<void> playMenu() => playLoop(GameAssets.menuMusic);

  Future<void> playRegion(int regionIndex) =>
      playLoop(GameAssets.musicForRegion(regionIndex));

  Future<void> playVictory() => playOnce(GameAssets.victoryMusic);

  Future<void> playDefeat() => playOnce(GameAssets.defeatMusic);

  Future<void> playLoop(String assetPath) async {
    if (_currentTrack == assetPath && !_isOneShot) return;
    _currentTrack = assetPath;
    _isOneShot = false;
    try {
      await _musicPlayer.stop();
      await _musicPlayer.setReleaseMode(ReleaseMode.loop);
      await _musicPlayer.play(AssetSource(assetPath));
    } catch (error) {
      debugPrint('Erro ao tocar música $assetPath: $error');
    }
  }

  Future<void> playOnce(String assetPath) async {
    if (_currentTrack == assetPath && _isOneShot) return;
    _currentTrack = assetPath;
    _isOneShot = true;
    try {
      await _musicPlayer.stop();
      await _musicPlayer.setReleaseMode(ReleaseMode.stop);
      await _musicPlayer.play(AssetSource(assetPath));
    } catch (error) {
      debugPrint('Erro ao tocar música $assetPath: $error');
    }
  }

  Future<void> stop() async {
    _currentTrack = null;
    _isOneShot = false;
    await _musicPlayer.stop();
  }

  @override
  void dispose() {
    _musicPlayer.dispose();
    super.dispose();
  }
}
