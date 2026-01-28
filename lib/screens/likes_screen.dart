import 'package:flutter/material.dart';
import 'package:instagram/constants/colors.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(
          'Notifications',
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: secondaryColor,
              child: Icon(Icons.person, color: primaryColor),
            ),
            title: Text(
              'user_${index + 1}',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'liked your post',
              style: TextStyle(color: secondaryColor),
            ),
            trailing: Icon(Icons.favorite, color: Colors.red, size: 20),
          );
        },
      ),
    );
  }
}
