import 'package:flutter/material.dart';
import 'package:user1_bookingrepair/Profile/rent_car_info_screen.dart';
import 'package:user1_bookingrepair/Profile/sale_car_info_screen.dart';
import 'package:user1_bookingrepair/login/login_screen.dart';

import '../Ewallet/e_wallet.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isButton1Active = false; // Track Button 1's state
  bool isButton2Active = false; // Track Button 2's state

  // Method to toggle Button 1
  void toggleButton1() {
    setState(() {
      isButton1Active = true;
      isButton2Active = false; // Deactivate Button 2 when Button 1 is activated
    });
  }

  // Method to toggle Button 2
  void toggleButton2() {
    setState(() {
      isButton2Active = true;
      isButton1Active = false; // Deactivate Button 1 when Button 2 is activated
    });
  }

  // Floating Action Button onPressed action
  void onFabPressed() {
    // Show the dialog when FAB is pressed
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Car"),
          content:
              const Text("Would you like to add a car for sale or for rent?"),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                // Navigate to the SellCarScreen when "For Sale" is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SellCarScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF28435A), // Active color
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
              ),
              child: const Text("For Sale"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                // Navigate to the RentCarScreen when "For Rent" is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RentCarScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF28435A), // Active color
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
              ),
              child: const Text("For Rent"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      endDrawer: SafeArea(
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color(0xFF28435A),
                ),
                child: Image.asset('assets/images/LogoType.png'),
              ),
              Card(
                child: ListTile(
                  title: Text('Profile'),
                  onTap: () {
                    // Handle end drawer item tap
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Settings'),
                  onTap: () {
                    // Handle end drawer item tap
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Logout'),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Are you sure you want to logout'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => LoginScreen()));
                                    },
                                    child: Text('Yes')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('No')),
                              ],
                            ));
                    // Handle end drawer item tap
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF28435A), // AppBar color
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white, // Back button icon color
          ),
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous page
          },
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Wallpaper Image with height up to the middle of the E-Wallet button
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: screenHeight *
                  0.2, // Set responsive height based on screen size
              child: Image.network(
                'https://iriga.gov.ph/wp-content/uploads/2022/11/placeholder.png', // Add your image URL
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Profile Picture
          Positioned(
            top: screenHeight *
                0.1, // Adjust top positioning based on screen size
            left: 30,
            child: Container(
              width: screenWidth * 0.3, // Make width responsive
              height:
                  screenWidth * 0.3, // Make height responsive (circle shape)
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300, // Profile picture background color
              ),
              child: ClipOval(
                child: Image.network(
                  'https://media.themoviedb.org/t/p/w300_and_h450_bestv2/zqBT16EdgLX9ToPwU6qhuY09QBI.jpg', // Replace with the actual URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Profile Data below the picture
          Positioned(
            top: screenHeight * 0.25, // Adjust position based on screen size
            left: 40,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mitchell Smith', // Example name
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Car Enthusiast and Seller',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 20),
                    SizedBox(width: 5),
                    Text(
                      '4.5/5',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Bio: Passionate about cars, fixing, and selling.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Elevated Button (E-Wallet)
          Positioned(
            top: screenHeight * 0.18, // Adjust top positioning
            right: 30,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => EWalletScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF28435A), // Button color
                foregroundColor: Colors.white, // Text color (white)
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      15), // Rounded corners for all sides
                ),
                fixedSize:
                    Size(screenWidth * 0.35, 40), // Responsive button size
              ),
              child: const Text("E-Wallet"), // Text inside the button
            ),
          ),

          // Bottom container
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.48, // Adjust height based on screen size
              color: Colors
                  .white, // Bottom container background color (simplified)
              child: Column(
                children: [
                  // Row of two buttons side by side (no space in between)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // First button
                        ElevatedButton(
                          onPressed: () {
                            toggleButton1(); // Activate Button 1
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isButton1Active
                                ? const Color(0xFF28435A) // Active color
                                : Colors.grey
                                    .shade200, // Inactive color (light grey)
                            foregroundColor: isButton1Active
                                ? Colors.white
                                : Colors.black, // Text color based on state
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    15), // Rounded top-left corner
                                bottomLeft: Radius.circular(
                                    15), // Rounded bottom-left corner
                              ),
                            ),
                            fixedSize: Size(screenWidth * 0.4,
                                40), // Responsive button size
                          ),
                          child:
                              const Text("For Sale"), // Text inside the button
                        ),
                        // Second button without any space
                        ElevatedButton(
                          onPressed: () {
                            toggleButton2(); // Activate Button 2
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isButton2Active
                                ? const Color(0xFF28435A) // Active color
                                : Colors.grey
                                    .shade200, // Inactive color (light grey)
                            foregroundColor: isButton2Active
                                ? Colors.white
                                : Colors.black, // Text color based on state
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(
                                    15), // Rounded top-right corner
                                bottomRight: Radius.circular(
                                    15), // Rounded bottom-right corner
                              ),
                            ),
                            fixedSize: Size(screenWidth * 0.4,
                                40), // Responsive button size
                          ),
                          child:
                              const Text("For Rent"), // Text inside the button
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Floating Action Button (FAB) added below the body content
      floatingActionButton: FloatingActionButton(
        onPressed: onFabPressed, // Handle FAB press
        backgroundColor: const Color(0xFF28435A),
        foregroundColor: Colors.white, // FAB color
        child: const Icon(Icons.add_circle_outline), // FAB icon
      ),
    );
  }
}
