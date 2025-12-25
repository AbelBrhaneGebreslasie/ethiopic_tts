import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ethiopic TTS',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TTSPage(),
    );
  }
}

class TTSPage extends StatefulWidget {
  const TTSPage({super.key});

  @override
  State<TTSPage> createState() => _TTSPageState();
}

class _TTSPageState extends State<TTSPage> {
  final TextEditingController _controller = TextEditingController();
  final AudioPlayer _player = AudioPlayer();

  // Map Ethiopic letters to audio files
  final Map<String, String> audioMap = {
    "ብ": "audio/ብ.mp3",
    "ር": "audio/ር.mp3",
    "ሃ": "audio/ሃ.mp3",
    "ነ": "audio/ነ.mp3",
    "ኣ": "audio/ኣ.mp3",
    "ቤ": "audio/ቤ.mp3",
    "ል": "audio/ል.mp3",
    "።": "audio/።.mp3",
  };

  Future<void> speakText(String text) async {
    for (int i = 0; i < text.length; i++) {
      String char = text[i];

      if (char == " ") {
        await Future.delayed(const Duration(milliseconds: 50));
        continue;
      }

      if (audioMap.containsKey(char)) {
        await _player.play(AssetSource(audioMap[char]!));
        await _player.onPlayerComplete.first;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ethiopic TTS')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Ethiopic text',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                speakText(_controller.text);
              },
              child: const Text('Play TTS'),
            ),
          ],
        ),
      ),
    );
  }
}
