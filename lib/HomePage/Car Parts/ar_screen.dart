import 'package:flutter/material.dart';

class ARScanningScreen extends StatefulWidget {
  final String imageUrl;

  const ARScanningScreen({
    super.key,
    required this.imageUrl,
  });

  @override
  _ARScanningScreenState createState() => _ARScanningScreenState();
}

class _ARScanningScreenState extends State<ARScanningScreen> {
  double topPosition = 100.0;
  double leftPosition = 100.0;
  double scale = 1.0; // Initial scale factor
  double previousScale = 1.0; // Store the previous scale for smooth zooming

  // List of background images
  final List<String> backgroundImages = [
    'https://iriga.gov.ph/wp-content/uploads/2022/11/placeholder.png',
  ];

  int currentBackgroundIndex = 0; // To track the current background image

  // Function to handle the zoom and drag gesture
  void onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      // Update the scale factor for zoom
      scale = previousScale * details.scale;

      // Update the position of the image when dragged
      leftPosition = details.localFocalPoint.dx - 100; // Adjust left position
      topPosition = details.localFocalPoint.dy - 100;  // Adjust top position
    });
  }

  void onScaleEnd(ScaleEndDetails details) {
    setState(() {
      previousScale = scale; // Save the scale for smooth transition
    });
  }

  // Function to cycle through background images
  void cycleBackgroundImage() {
    setState(() {
      currentBackgroundIndex = (currentBackgroundIndex + 1) % backgroundImages.length; // Cycle through the images
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "AR Scanning",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF28435A),
        actions: [
          // Button to cycle through the background images
          IconButton(
            onPressed: cycleBackgroundImage,
            icon: const Icon(Icons.refresh), // Refresh icon to indicate cycling
            color: Colors.white,
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            // Camera-like background with image, dynamically changed
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.8), // Simulates a camera feed with darkened overlay
              child: Center(
                child: Image.network(
                  backgroundImages[currentBackgroundIndex], // Display the current background image
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            // Positioned draggable and zoomable image
            Positioned(
              top: topPosition,
              left: leftPosition,
              child: GestureDetector(
                onScaleUpdate: onScaleUpdate, // Handle both zoom and drag
                onScaleEnd: onScaleEnd, // Save scale value after zoom ends
                child: Transform(
                  transform: Matrix4.identity()..scale(scale), // Apply zoom
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      widget.imageUrl, // Display the passed image
                      width: 200,
                      height: 200,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
