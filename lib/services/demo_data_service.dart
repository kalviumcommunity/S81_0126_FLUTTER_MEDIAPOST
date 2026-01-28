import 'package:instagram/models/post.dart';
import 'package:instagram/models/user.dart';

class DemoDataService {
  static final List<User> demoUsers = [
    User(
      uid: 'user1',
      email: 'john_doe@example.com',
      username: 'john_doe',
      bio: 'Photography enthusiast 📸',
      photoUrl:
          'https://ui-avatars.com/api/?name=john_doe&background=0D8ABC&color=fff',
      followers: ['user2', 'user3'],
      following: ['user2'],
      createdAt: DateTime.now().subtract(Duration(days: 30)),
    ),
    User(
      uid: 'user2',
      email: 'jane_smith@example.com',
      username: 'jane_smith',
      bio: 'Travel & lifestyle ✈️',
      photoUrl:
          'https://ui-avatars.com/api/?name=jane_smith&background=FF6B6B&color=fff',
      followers: ['user1', 'user3'],
      following: ['user1', 'user3'],
      createdAt: DateTime.now().subtract(Duration(days: 45)),
    ),
    User(
      uid: 'user3',
      email: 'alex_tech@example.com',
      username: 'alex_tech',
      bio: 'Tech lover & coder 💻',
      photoUrl:
          'https://ui-avatars.com/api/?name=alex_tech&background=4ECDC4&color=fff',
      followers: ['user1', 'user2'],
      following: ['user2'],
      createdAt: DateTime.now().subtract(Duration(days: 60)),
    ),
  ];

  static final List<Post> demoPosts = [
    Post(
      postId: 'post1',
      uid: 'user1',
      username: 'john_doe',
      userImage: 'https://i.pravatar.cc/150?img=1',
      description: 'Beautiful sunset at the beach! 🌅 #photography #nature',
      postUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=500&h=500&fit=crop',
      likes: ['user2', 'user3', 'user1'],
      datePublished: DateTime.now().subtract(Duration(hours: 2)),
      commentCount: 5,
    ),
    Post(
      postId: 'post2',
      uid: 'user2',
      username: 'jane_smith',
      userImage: 'https://i.pravatar.cc/150?img=2',
      description:
          'Exploring the ancient temples of Thailand 🇹🇭 Amazing culture!',
      postUrl:
          'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=500&h=500&fit=crop',
      likes: ['user1', 'user3'],
      datePublished: DateTime.now().subtract(Duration(hours: 5)),
      commentCount: 12,
    ),
    Post(
      postId: 'post3',
      uid: 'user3',
      username: 'alex_tech',
      userImage: 'https://i.pravatar.cc/150?img=3',
      description: 'Just launched my new Flutter app! 💻✨ #flutter #development',
      postUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=500&h=500&fit=crop',
      likes: ['user1', 'user2'],
      datePublished: DateTime.now().subtract(Duration(hours: 8)),
      commentCount: 8,
    ),
    Post(
      postId: 'post4',
      uid: 'user1',
      username: 'john_doe',
      userImage: 'https://i.pravatar.cc/150?img=1',
      description: 'Mountain hiking season is here! 🏔️ #adventure #outdoors',
      postUrl:
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=500&h=500&fit=crop',
      likes: ['user2'],
      datePublished: DateTime.now().subtract(Duration(hours: 12)),
      commentCount: 3,
    ),
    Post(
      postId: 'post5',
      uid: 'user2',
      username: 'jane_smith',
      userImage: 'https://i.pravatar.cc/150?img=2',
      description: 'Morning coffee with a view 🌄☕ #lifestyle #morning',
      postUrl:
          'https://images.unsplash.com/photo-1495521821757-a1efb6729352?w=500&h=500&fit=crop',
      likes: ['user1', 'user3', 'user2'],
      datePublished: DateTime.now().subtract(Duration(hours: 15)),
      commentCount: 7,
    ),
    Post(
      postId: 'post6',
      uid: 'user3',
      username: 'alex_tech',
      userImage: 'https://i.pravatar.cc/150?img=3',
      description: 'Debugging at 2 AM be like... 😅 #coding #programminglife',
      postUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=500&h=500&fit=crop',
      likes: ['user1'],
      datePublished: DateTime.now().subtract(Duration(days: 1)),
      commentCount: 4,
    ),
  ];

  static User getDemoUser(String uid) {
    try {
      return demoUsers.firstWhere((user) => user.uid == uid);
    } catch (e) {
      return demoUsers.first;
    }
  }

  static List<Post> getDemoPosts() {
    return demoPosts;
  }

  static Post updatePostLike(Post post, String uid, bool isLike) {
    List<String> updatedLikes = List.from(post.likes);
    if (isLike) {
      if (!updatedLikes.contains(uid)) {
        updatedLikes.add(uid);
      }
    } else {
      updatedLikes.remove(uid);
    }

    return Post(
      postId: post.postId,
      uid: post.uid,
      username: post.username,
      userImage: post.userImage,
      description: post.description,
      postUrl: post.postUrl,
      likes: updatedLikes,
      datePublished: post.datePublished,
      commentCount: post.commentCount,
    );
  }
}
