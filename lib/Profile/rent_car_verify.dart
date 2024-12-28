import 'package:flutter/material.dart';

class CarPapersUploadScreen extends StatefulWidget {
  const CarPapersUploadScreen({super.key});

  @override
  _CarPapersUploadScreenState createState() => _CarPapersUploadScreenState();
}

class _CarPapersUploadScreenState extends State<CarPapersUploadScreen> {
  // Variable to track whether the file is uploaded
  bool isUploaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF28435A),
        title: const Text("Upload Car Papers"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Placeholder for uploading car papers
            GestureDetector(
              onTap: () {
                // Simulate uploading action by changing the state
                setState(() {
                  isUploaded = true;
                });
                print("Car papers upload action triggered");
              },
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: const Center(
                  child: Icon(
                    Icons.upload_file,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Upload Car Papers", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Placeholder for next button press action
                print(
                    isUploaded ? "Navigating to List" : "Upload Papers First");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF28435A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
              ),
              child: Text(isUploaded
                  ? "To List"
                  : "Next"), // Button text changes based on isUploaded
            ),
          ],
        ),
      ),
    );
  }
}
