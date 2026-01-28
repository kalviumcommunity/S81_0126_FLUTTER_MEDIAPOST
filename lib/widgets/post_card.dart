import 'package:flutter/material.dart';
import 'package:instagram/constants/colors.dart';

class PostCard extends StatefulWidget {
  final String postId;
  final String uid;
  final String username;
  final String userImage;
  final String description;
  final String postUrl;
  final List<String> likes;
  final DateTime datePublished;
  final int commentCount;
  final String currentUid;
  final Function onLike;
  final Function onComment;

  const PostCard({
    Key? key,
    required this.postId,
    required this.uid,
    required this.username,
    required this.userImage,
    required this.description,
    required this.postUrl,
    required this.likes,
    required this.datePublished,
    required this.commentCount,
    required this.currentUid,
    required this.onLike,
    required this.onComment,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(widget.currentUid);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      color: mobileBackgroundColor,
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: isMobile ? 0 : 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with user info
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: widget.userImage.isNotEmpty
                      ? NetworkImage(widget.userImage)
                      : null,
                  child: widget.userImage.isEmpty
                      ? Icon(Icons.person, color: secondaryColor)
                      : null,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.username,
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.more_vert, color: secondaryColor, size: 16),
              ],
            ),
          ),
          SizedBox(height: 12),
          // Post Image
          if (widget.postUrl.isNotEmpty)
            Container(
              width: double.infinity,
              constraints: BoxConstraints(maxHeight: 400),
              child: Image.network(
                widget.postUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300,
                    color: secondaryColor,
                    child: Icon(Icons.broken_image, color: primaryColor),
                  );
                },
              ),
            ),
          SizedBox(height: 12),
          // Like, Comment, Share buttons
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                        widget.onLike();
                      },
                      child: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : secondaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => widget.onComment(),
                      child: Icon(
                        Icons.comment_outlined,
                        color: secondaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 16),
                    Icon(
                      Icons.share,
                      color: secondaryColor,
                      size: 24,
                    ),
                  ],
                ),
                Icon(Icons.bookmark_border, color: secondaryColor, size: 24),
              ],
            ),
          ),
          SizedBox(height: 8),
          // Likes count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${widget.likes.length} likes',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          // Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.username,
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: ' ${widget.description}',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          // Comments count
          if (widget.commentCount > 0)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => widget.onComment(),
                  child: Text(
                    'View all ${widget.commentCount} comments',
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(height: 8),
          // Timestamp
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${widget.datePublished.day} days ago',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
