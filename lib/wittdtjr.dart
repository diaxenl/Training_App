import 'package:flutter/material.dart';

class WittdtjrPage extends StatelessWidget {
  const WittdtjrPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WITTDTJR'),
        // Increase the AppBar's height
        toolbarHeight: 180.0, // Adjust the height to your preference
        // Ensure content is not obscured by the notch
        elevation: 0.0, // Optional: remove shadow if preferred
      ),
      body: const SafeArea(
        // Wrap your body with SafeArea
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            // Wrap with SingleChildScrollView for better handling of screen space
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Drop-Stop 30/30: Greet the customer and ask “What are you working on today?”',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                    'Scan the Customer’s AZ Rewards Card or Enter Their Phone Number: This includes for returns.',
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text(
                    'Use WITTDTJR and Z-net Selling 1-2-3: Sell the complete job.',
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text('Use the Proper Checkout Challenge Selling Techniques.',
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text('Use the Proper Oil/Air Selling Techniques.',
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text(
                    'Smile and Thank the Customer: Thank the customer for shopping with you.',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
