class Post {
  final String postId;
  final String uid;
  final String username;
  final String userImage;
  final String description;
  final String postUrl;
  final List<String> likes;
  final DateTime datePublished;
  final int commentCount;

  Post({
    required this.postId,
    required this.uid,
    required this.username,
    required this.userImage,
    required this.description,
    required this.postUrl,
    required this.likes,
    required this.datePublished,
    required this.commentCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'uid': uid,
      'username': username,
      'userImage': userImage,
      'description': description,
      'postUrl': postUrl,
      'likes': likes,
      'datePublished': datePublished,
      'commentCount': commentCount,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map['postId'] ?? '',
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      userImage: map['userImage'] ?? '',
      description: map['description'] ?? '',
      postUrl: map['postUrl'] ?? '',
      likes: List<String>.from(map['likes'] ?? []),
      datePublished: map['datePublished']?.toDate() ?? DateTime.now(),
      commentCount: map['commentCount'] ?? 0,
    );
  }
}
