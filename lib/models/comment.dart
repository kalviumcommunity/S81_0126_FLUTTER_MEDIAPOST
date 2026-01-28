class Comment {
  final String commentId;
  final String postId;
  final String uid;
  final String name;
  final String profilePic;
  final String text;
  final DateTime datePublished;
  final List<String> likes;

  Comment({
    required this.commentId,
    required this.postId,
    required this.uid,
    required this.name,
    required this.profilePic,
    required this.text,
    required this.datePublished,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return {
      'commentId': commentId,
      'postId': postId,
      'uid': uid,
      'name': name,
      'profilePic': profilePic,
      'text': text,
      'datePublished': datePublished,
      'likes': likes,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      commentId: map['commentId'] ?? '',
      postId: map['postId'] ?? '',
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      text: map['text'] ?? '',
      datePublished: map['datePublished']?.toDate() ?? DateTime.now(),
      likes: List<String>.from(map['likes'] ?? []),
    );
  }
}
