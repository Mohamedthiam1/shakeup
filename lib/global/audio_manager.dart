import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final AudioPlayer _player = AudioPlayer(); // Instance unique

  static Future<void> play() async {
    await _player.setReleaseMode(ReleaseMode.loop); // Répéter en boucle
    await _player.play(AssetSource('music/background.mp3'));

  }

  static Future<void> stop() async {
    // await _player.setReleaseMode(ReleaseMode.loop); // Répéter en boucle
    await _player.stop();
  }

}
