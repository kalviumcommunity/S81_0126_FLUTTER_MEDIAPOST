import 'package:flutter/material.dart';
import 'package:instagram/constants/colors.dart';
import 'package:instagram/services/firestore_service.dart';
import 'package:instagram/services/demo_data_service.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/models/post.dart';
import 'package:instagram/widgets/post_card.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  late User _user;
  late List<Post> _userPosts;
  bool _isLoading = true;
  bool _useDemo = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    if (_useDemo) {
      try {
        _user = DemoDataService.getDemoUser(widget.uid);
        _userPosts = DemoDataService.getDemoPosts()
            .where((post) => post.uid == widget.uid)
            .toList();
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      try {
        var userDoc = await _firestoreService.getUserData(widget.uid);
        if (userDoc.exists) {
          setState(() {
            _user = User.fromMap(userDoc.data() as Map<String, dynamic>);
            _isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(color: blueColor),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _user.username,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _user.email,
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 48,
                  backgroundImage: _user.photoUrl.isNotEmpty
                      ? NetworkImage(_user.photoUrl)
                      : null,
                  child: _user.photoUrl.isEmpty
                      ? Icon(Icons.person, color: secondaryColor, size: 48)
                      : null,
                ),
              ],
            ),
            SizedBox(height: 24),
            // Bio
            Text(
              _user.bio,
              style: TextStyle(color: primaryColor),
            ),
            SizedBox(height: 16),
            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      _userPosts.length.toString(),
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Posts',
                      style: TextStyle(color: secondaryColor, fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      _user.followers.length.toString(),
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Followers',
                      style: TextStyle(color: secondaryColor, fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      _user.following.length.toString(),
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Following',
                      style: TextStyle(color: secondaryColor, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            // Edit profile button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Edit profile coming soon')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: blueColor,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Edit Profile'),
              ),
            ),
            SizedBox(height: 32),
            // User posts
            Text(
              'Posts',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            if (_userPosts.isEmpty)
              Center(
                child: Text(
                  'No posts yet',
                  style: TextStyle(color: secondaryColor),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _userPosts.length,
                itemBuilder: (context, index) {
                  var post = _userPosts[index];

                  return PostCard(
                    postId: post.postId,
                    uid: post.uid,
                    username: post.username,
                    userImage: post.userImage,
                    description: post.description,
                    postUrl: post.postUrl,
                    likes: post.likes,
                    datePublished: post.datePublished,
                    commentCount: post.commentCount,
                    currentUid: widget.uid,
                    onLike: () {},
                    onComment: () {},
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
