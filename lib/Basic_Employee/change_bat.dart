import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPage extends StatelessWidget {
  final String buttonText;
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'XN4GSRObmBA', // The video ID extracted from the URL
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  DetailPage({super.key, required this.buttonText});

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
                  'Changing a Battery',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Step 1: Locate the Battery',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'The battery is typically located in the engine bay. '
                  'If you are having trouble finding it, refer to your '
                  'vehicle’s manual for guidance.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                Text(
                  'Step 2: Remove the Old Battery',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Before removing the old battery, make sure that the vehicle '
                  'is off. Use a wrench to loosen the bolts that hold the '
                  'battery in place.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                // Continue adding steps and text for the guide.
              ],
            ),
          ),
        ],
      ),
    );
  }
}
