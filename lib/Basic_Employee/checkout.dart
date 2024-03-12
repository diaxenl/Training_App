import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CheckoutPage extends StatelessWidget {
  final String buttonText;
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'dQw4w9WgXcQ', // The video ID extracted from the URL
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  CheckoutPage({super.key, required this.buttonText});

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
                const ListTile(
                  leading: Icon(Icons.access_time, color: Colors.blue),
                  title: Text('1-2 min/Easy Difficulty',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('What You Need',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const Text('1. Just the computer'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Image.asset('assets/tester_dock_image.png', width: 100),
                      // Example image, replace with your actual asset
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Introduction',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const Text(
                    'This will be one of the most used functions you will need to learn as an AutoZoner. The process is simple and being fast and efficient with it will go a long way towards customer satisfaction. If at any point the transaction needs to stop you can click pending cart to come back to it later.'),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Step 1',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const Text(
                    'Scan each item for the customer and follow good WITTDJR guidelines to ensure they have everything they need to get the job done.'),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Step 2',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const Text(
                    'Ask the customer for a phone number and enter it in on the top. If they do not have a rewards account ask them if they would like to make one, use enroll customer to make the account.'),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Step 3',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const Text(
                    'Continue with checkout by clicking checkout and selecting the method of payment requested by the customer. Take the tender and thank them for shopping with us.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
