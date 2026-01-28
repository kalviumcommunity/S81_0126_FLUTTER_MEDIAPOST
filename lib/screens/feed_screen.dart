import 'package:flutter/material.dart';
import 'package:instagram/constants/colors.dart';
import 'package:instagram/services/firestore_service.dart';
import 'package:instagram/services/demo_data_service.dart';
import 'package:instagram/models/post.dart';
import 'package:instagram/widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  final String currentUid;

  const FeedScreen({Key? key, required this.currentUid}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  late List<Post> _posts;
  bool _useFirebase = false;

  @override
  void initState() {
    super.initState();
    _posts = DemoDataService.getDemoPosts();
  }

  void _togglePostLike(int index, String uid) {
    setState(() {
      _posts[index] = DemoDataService.updatePostLike(
        _posts[index],
        uid,
        !_posts[index].likes.contains(uid),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use demo data for now
    if (!_useFirebase) {
      return _buildDemoFeed();
    }

    // Use Firebase when enabled
    return StreamBuilder(
      stream: _firestoreService.getAllPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: blueColor),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No posts yet. Start following users!',
              style: TextStyle(color: secondaryColor),
            ),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var post = snapshot.data!.docs[index];
            var postData = post.data() as Map<String, dynamic>;

            return PostCard(
              postId: post.id,
              uid: postData['uid'] ?? '',
              username: postData['username'] ?? 'Unknown',
              userImage: postData['userImage'] ?? '',
              description: postData['description'] ?? '',
              postUrl: postData['postUrl'] ?? '',
              likes: List<String>.from(postData['likes'] ?? []),
              datePublished:
                  postData['datePublished']?.toDate() ?? DateTime.now(),
              commentCount: postData['commentCount'] ?? 0,
              currentUid: widget.currentUid,
              onLike: () {
                if (postData['likes'].contains(widget.currentUid)) {
                  _firestoreService.unlikePost(post.id, widget.currentUid);
                } else {
                  _firestoreService.likePost(post.id, widget.currentUid);
                }
              },
              onComment: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Comments feature coming soon')),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildDemoFeed() {
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        var post = _posts[index];

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
          currentUid: widget.currentUid,
          onLike: () {
            _togglePostLike(index, widget.currentUid);
          },
          onComment: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    '💬 ${post.commentCount} comments on this post!'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        );
      },
    );
  }
}
