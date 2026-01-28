import 'package:flutter/material.dart';
import 'package:instagram/constants/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _captionController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(
          'New Post',
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image placeholder
              Container(
                height: isMobile ? 300 : 400,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(38, 38, 38, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_not_supported,
                      color: secondaryColor,
                      size: 48,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Select an image',
                      style: TextStyle(color: secondaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              // Select image button
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Image picker coming soon')),
                  );
                },
                icon: Icon(Icons.add_a_photo),
                label: Text('Choose from Gallery'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: blueColor,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Caption field
              TextField(
                controller: _captionController,
                style: TextStyle(color: primaryColor),
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write a caption...',
                  hintStyle: TextStyle(color: secondaryColor),
                  filled: true,
                  fillColor: Color.fromRGBO(38, 38, 38, 1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 24),
              // Share button
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        setState(() => _isLoading = true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Sharing coming soon')),
                        );
                        Future.delayed(Duration(seconds: 2), () {
                          setState(() => _isLoading = false);
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: blueColor,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: primaryColor,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Share',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }
}
