import 'package:flutter/material.dart';
import 'package:instagram/constants/colors.dart';
import 'package:instagram/services/firestore_service.dart';
import 'package:instagram/services/demo_data_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;
  bool _useDemo = true;

  void _searchUsers(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      if (_useDemo) {
        // Search demo users
        var results = DemoDataService.demoUsers
            .where((user) =>
                user.username.toLowerCase().contains(query.toLowerCase()) ||
                user.email.toLowerCase().contains(query.toLowerCase()))
            .toList();

        setState(() {
          _searchResults = results
              .map((user) => {
                    'uid': user.uid,
                    'username': user.username,
                    'email': user.email,
                    'photoUrl': user.photoUrl,
                    'bio': user.bio,
                  })
              .toList();
          _isSearching = false;
        });
      } else {
        var results = await _firestoreService.searchUsers(query);
        setState(() {
          _searchResults = results.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            data['uid'] = doc.id;
            return data;
          }).toList();
          _isSearching = false;
        });
      }
    } catch (e) {
      setState(() {
        _isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Search bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: TextField(
              controller: _searchController,
              onChanged: _searchUsers,
              style: TextStyle(color: primaryColor),
              decoration: InputDecoration(
                hintText: 'Search users...',
                hintStyle: TextStyle(color: secondaryColor),
                filled: true,
                fillColor: Color.fromRGBO(38, 38, 38, 1),
                prefixIcon: Icon(Icons.search, color: secondaryColor),
                suffixIcon: _searchController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          _searchUsers('');
                        },
                        child: Icon(Icons.clear, color: secondaryColor),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Search results
          Expanded(
            child: _isSearching
                ? Center(
                    child: CircularProgressIndicator(color: blueColor),
                  )
                : _searchResults.isEmpty
                    ? Center(
                        child: Text(
                          _searchController.text.isEmpty
                              ? 'Search for users'
                              : 'No users found',
                          style: TextStyle(color: secondaryColor),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          var user = _searchResults[index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 24,
                              backgroundImage: user['photoUrl'] != null &&
                                      user['photoUrl'].isNotEmpty
                                  ? NetworkImage(user['photoUrl'])
                                  : null,
                              child: user['photoUrl'] == null ||
                                      user['photoUrl'].isEmpty
                                  ? Icon(Icons.person, color: secondaryColor)
                                  : null,
                            ),
                            title: Text(
                              user['username'] ?? 'Unknown',
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              user['bio'] ?? user['email'] ?? '',
                              style: TextStyle(color: secondaryColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Viewing ${user['username']}\'s profile'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
