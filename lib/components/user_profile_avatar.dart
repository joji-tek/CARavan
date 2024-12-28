import 'package:flutter/material.dart';

class UserProfileAvatar extends StatelessWidget {
  const UserProfileAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Center(
      child: Material(
        elevation: 5,
        shape: const CircleBorder(),
        child: CircleAvatar(
          radius: screenSize.width * 0.2,
          backgroundImage: const NetworkImage(
            'https://media.themoviedb.org/t/p/w300_and_h450_bestv2/zqBT16EdgLX9ToPwU6qhuY09QBI.jpg',
          ),
        ),
      ),
    );
  }
}
