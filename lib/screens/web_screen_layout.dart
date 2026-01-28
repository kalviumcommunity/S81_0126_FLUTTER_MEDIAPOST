import 'package:flutter/material.dart';
import 'package:instagram/constants/colors.dart';
import 'package:instagram/screens/feed_screen.dart';
import 'package:instagram/screens/search_screen.dart';
import 'package:instagram/screens/add_post_screen.dart';
import 'package:instagram/screens/likes_screen.dart';
import 'package:instagram/screens/profile_screen.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;
  final String _currentUid = 'demo_user'; // Replace with actual user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Text(
          'Instagram',
          style: TextStyle(
            color: primaryColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
            onPressed: () => setState(() => _page = 0),
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
            onPressed: () => setState(() => _page = 1),
          ),
          IconButton(
            icon: Icon(
              Icons.add_circle,
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
            onPressed: () => setState(() => _page = 2),
          ),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? primaryColor : secondaryColor,
            ),
            onPressed: () => setState(() => _page = 3),
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: _page == 4 ? primaryColor : secondaryColor,
            ),
            onPressed: () => setState(() => _page = 4),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: mobileBackgroundColor,
            ),
          ),
          Expanded(
            flex: 5,
            child: _buildPage(),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: mobileBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage() {
    switch (_page) {
      case 0:
        return FeedScreen(currentUid: _currentUid);
      case 1:
        return SearchScreen();
      case 2:
        return AddPostScreen();
      case 3:
        return LikesScreen();
      case 4:
        return ProfileScreen(uid: _currentUid);
      default:
        return FeedScreen(currentUid: _currentUid);
    }
  }
}
