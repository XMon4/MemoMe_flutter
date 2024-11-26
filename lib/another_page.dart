import 'package:flutter/material.dart';
import 'memome_home.dart';

class AnotherPage extends StatefulWidget {
  const AnotherPage({super.key});

  @override
  _AnotherPageState createState() => _AnotherPageState();
}

class _AnotherPageState extends State<AnotherPage> {
  // List of images to be used as background
  final List<String> _images = [
    'assets/1729786435318.jpg',
    'assets/1729786435317.jpg',
    'assets/1729789689129.jpg',
    'assets/1729789689128.jpg',
  ];

  int _currentIndex = 0; // Track the current image index

  void _navigateToMemome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MemomeHome()),
    );
  }

  // Function to switch to the next image
  void _changeBackground() {
    setState(() {
      // Increment the index, and reset to 0 if it exceeds the number of images
      _currentIndex = (_currentIndex + 1) % _images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Another Page'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_images[_currentIndex]), // Set background to current image
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Container with background for readable text
              Container(
                padding: const EdgeInsets.all(10),
                color: Colors.black.withOpacity(0.5), // Semi-transparent background
                child: const Text(
                  'Montaro Salafta',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text for contrast
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Wrap widget for stars and text
              const Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Text('⭐', style: TextStyle(fontSize: 24)),
                  SizedBox(width: 10),
                  Text(
                    'Advanced Mobile Application Task 2',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Text('⭐', style: TextStyle(fontSize: 24)),
                ],
              ),
              const SizedBox(height: 20),

              // Blue container showing all the images
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: _images.map((image) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Image.asset(
                        image,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),

              // Button to change the background
              ElevatedButton(
                onPressed: _changeBackground, // Change background on press
                child: const Text('Change Background'),
              ),
              const SizedBox(height: 20),

              // Button to navigate to Memome home page
              ElevatedButton(
                onPressed: _navigateToMemome, // Call the navigate function
                child: const Text('Go to MemoMe Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
