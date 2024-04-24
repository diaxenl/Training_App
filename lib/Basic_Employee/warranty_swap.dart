import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Content Page
class WarrantySwapPage extends StatelessWidget {
  final String buttonText;
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'dQw4w9WgXcQ', // The video ID extracted from the URL
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  WarrantySwapPage({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(buttonText),
        toolbarHeight: 180.0,
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
                  'Warranty Swap',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'Enter customer\'s phone number to pull up their account and check their warranties (pictured below)',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'Check to see that the item in question still hase and active warranty. Confirm that the replacement is in stock and if it is get it for the customer.'
                  'Start the swap from this screen and follow on screen instrructions.',
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
