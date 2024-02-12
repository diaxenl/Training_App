import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TimeOffPage extends StatelessWidget {
  final String buttonText;
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'dQw4w9WgXcQ', // The video ID extracted from the URL
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  TimeOffPage({super.key, required this.buttonText});

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
                  title: Text('3-5 min/Easy Difficulty',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('What You Need',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const Text('1. AutoZoner account'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      const Expanded(
                          child: Text('2. Store Computer'
                              'or'
                              'ESS41-Reflexis app')),
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
                    'In this tutorial we will walk you through applying for time off and ensure that all the important aspects of this are covered'),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Step 1',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const Text(
                    'On the computer move the mouse to the top left so the programs will appear. Click on zTask admin'),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Step 2',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const Text(
                    'Login and click on the Person icon to bring up the list of functions.  Click on Day Off or Time Off Request, depending on if you need more than one day off.'),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Step 3',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const Text(
                    'Click on Add and fill out the form that appears. When complete your Store Manager will review it before it can be accepted.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
