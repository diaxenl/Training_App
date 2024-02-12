import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ChangeWiperBladePage extends StatelessWidget {
  final String buttonText;
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'zMIfCVYcGys', // The video ID extracted from the URL
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  ChangeWiperBladePage({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(buttonText),
        toolbarHeight: 180.0, // Increased height
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              _controller.addListener(() {});
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Changing a Wiper Blade',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'Remove old blade.'
                  'If it is a hook design you simply need to pull it off, some will require you you push a button or squeeze the sides of the connection',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
