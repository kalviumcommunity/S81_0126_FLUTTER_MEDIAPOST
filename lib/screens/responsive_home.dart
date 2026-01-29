import 'package:flutter/material.dart';
import '../responsive/responsive_layout_screen.dart';
import '../utils/responsive_helper.dart';
import '../utils/colors.dart';

/// Responsive Home Screen - Demonstrates adaptive mobile UI design
/// Automatically adjusts layout, spacing, and typography across all screen sizes
/// 
/// Features:
/// - Dynamic layout switching (Mobile <600px, Tablet ≥600px)
/// - Responsive typography (font sizes scale with screen width)
/// - Flexible spacing (padding/margins scale with device)
/// - Orientation-aware layout (portrait/landscape support)
/// - Touch-friendly targets (min 48x48dp on mobile)
class ResponsiveHome extends StatefulWidget {
  const ResponsiveHome({Key? key}) : super(key: key);

  @override
  State<ResponsiveHome> createState() => _ResponsiveHomeState();
}

class _ResponsiveHomeState extends State<ResponsiveHome>
    with WidgetsBindingObserver {
  late Orientation _currentOrientation;
  late bool _isPortrait;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _currentOrientation = MediaQuery.of(context).orientation;
    _isPortrait = _currentOrientation == Orientation.portrait;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // Rebuild when orientation changes
    final newOrientation = MediaQuery.of(context).orientation;
    if (_currentOrientation != newOrientation) {
      setState(() {
        _currentOrientation = newOrientation;
        _isPortrait = _currentOrientation == Orientation.portrait;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomBar(context),
      floatingActionButton: _buildFAB(context),
    );
  }

  /// Adaptive AppBar that adjusts to screen size
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = ResponsiveHelper.isTablet(context);
    final appBarHeight = isTablet ? 70.0 : 56.0;

    return AppBar(
      elevation: 2,
      backgroundColor: Colors.white,
      toolbarHeight: appBarHeight,
      title: Text(
        'Instagram Clone',
        style: TextStyle(
          color: Colors.black,
          fontSize: ResponsiveHelper.getHeadlineSmall(context),
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: false,
      actions: [
        // Responsive icon buttons
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () => _showSnackBar(context, 'Search tapped'),
          tooltip: 'Search',
          iconSize: ResponsiveHelper.getIconSize(context),
        ),
        IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.black),
          onPressed: () => _showSnackBar(context, 'Notifications tapped'),
          tooltip: 'Notifications',
          iconSize: ResponsiveHelper.getIconSize(context),
        ),
        SizedBox(width: ResponsiveHelper.horizontalPadding(context) / 2),
      ],
    );
  }

  /// Responsive main body content
  Widget _buildBody(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine layout based on available width
        final isTablet = constraints.maxWidth > 600;
        final isMobile = constraints.maxWidth <= 600;

        if (isTablet && !_isPortrait) {
          // Landscape tablet - 2-column layout
          return _buildTabletLandscapeLayout(context, constraints);
        } else if (isTablet && _isPortrait) {
          // Portrait tablet - responsive grid
          return _buildTabletPortraitLayout(context, constraints);
        } else {
          // Mobile phone - single column layout
          return _buildMobileLayout(context, constraints);
        }
      },
    );
  }

  /// Mobile layout - Single column with full-width cards
  Widget _buildMobileLayout(BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildStorySection(context),
          SizedBox(height: ResponsiveHelper.verticalPadding(context)),
          _buildFeedSection(context, itemCount: 5),
        ],
      ),
    );
  }

  /// Tablet portrait layout - Responsive grid with sidebar
  Widget _buildTabletPortraitLayout(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    return Row(
      children: [
        // Sidebar - responsive width
        SizedBox(
          width: constraints.maxWidth * 0.25,
          child: Container(
            color: Colors.grey[100],
            child: _buildSidebarMenu(context),
          ),
        ),
        // Main content area
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildStorySection(context),
                SizedBox(height: ResponsiveHelper.verticalPadding(context)),
                _buildFeedSection(context, itemCount: 5),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Tablet landscape layout - 2-column with sidebar
  Widget _buildTabletLandscapeLayout(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    return Row(
      children: [
        // Left sidebar - responsive
        SizedBox(
          width: constraints.maxWidth * 0.2,
          child: Container(
            color: Colors.grey[100],
            padding: EdgeInsets.all(
              ResponsiveHelper.horizontalPadding(context),
            ),
            child: _buildSidebarMenu(context),
          ),
        ),
        // Main content - responsive columns
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(
              ResponsiveHelper.horizontalPadding(context),
            ),
            child: Row(
              children: [
                // Left column
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildStorySection(context),
                        SizedBox(
                          height:
                              ResponsiveHelper.verticalPadding(context) * 1.5,
                        ),
                        _buildFeedSection(context, itemCount: 4),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: ResponsiveHelper.horizontalPadding(context) * 2,
                ),
                // Right column - suggested users
                SizedBox(
                  width: constraints.maxWidth * 0.22,
                  child: SingleChildScrollView(
                    child: _buildSuggestedUsers(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Story carousel section - responsive height
  Widget _buildStorySection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final storyHeight = screenHeight * 0.15;

    return Container(
      height: storyHeight,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.horizontalPadding(context),
        vertical: ResponsiveHelper.verticalPadding(context) / 2,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: ResponsiveHelper.horizontalPadding(context) / 2,
            ),
            child: _buildStoryItem(context),
          );
        },
      ),
    );
  }

  /// Individual story item
  Widget _buildStoryItem(BuildContext context) {
    final size = ResponsiveHelper.getResponsiveSize(context, mobile: 50, tablet: 60);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.pink, width: 2),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Icon(
              Icons.person,
              color: Colors.grey[600],
            ),
          ),
        ),
        SizedBox(height: ResponsiveHelper.verticalPadding(context) / 4),
        Text(
          'User',
          style: TextStyle(
            fontSize: ResponsiveHelper.getBodySmall(context),
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  /// Feed section with responsive cards
  Widget _buildFeedSection(BuildContext context, {required int itemCount}) {
    return Column(
      children: List.generate(
        itemCount,
        (index) => Padding(
          padding: EdgeInsets.only(
            bottom: ResponsiveHelper.verticalPadding(context),
          ),
          child: _buildPostCard(context, index + 1),
        ),
      ),
    );
  }

  /// Responsive post card
  Widget _buildPostCard(BuildContext context, int postNumber) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[200]!),
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header
          Padding(
            padding: EdgeInsets.all(
              ResponsiveHelper.horizontalPadding(context),
            ),
            child: Row(
              children: [
                // User avatar
                Container(
                  width: ResponsiveHelper.getResponsiveSize(
                    context,
                    mobile: 40,
                    tablet: 48,
                  ),
                  height: ResponsiveHelper.getResponsiveSize(
                    context,
                    mobile: 40,
                    tablet: 48,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.pink, width: 1),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(
                  width: ResponsiveHelper.horizontalPadding(context) / 2,
                ),
                // User info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'user_name_$postNumber',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getBodyMedium(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Location, Country',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getBodySmall(context),
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                // Menu button
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () =>
                      _showSnackBar(context, 'Menu for post $postNumber'),
                  iconSize: ResponsiveHelper.getIconSize(context),
                ),
              ],
            ),
          ),
          // Post image - responsive aspect ratio
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.grey[300],
              child: Center(
                child: Icon(
                  Icons.image,
                  size: ResponsiveHelper.getResponsiveSize(
                    context,
                    mobile: 50,
                    tablet: 80,
                  ),
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          // Post interactions
          Padding(
            padding: EdgeInsets.all(
              ResponsiveHelper.horizontalPadding(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Like, comment, share buttons
                Row(
                  children: [
                    _buildIconButton(
                      context,
                      Icons.favorite_border,
                      'Like',
                      () => _showSnackBar(context, 'Liked post $postNumber'),
                    ),
                    _buildIconButton(
                      context,
                      Icons.comment_outlined,
                      'Comment',
                      () =>
                          _showSnackBar(context, 'Commenting on post $postNumber'),
                    ),
                    _buildIconButton(
                      context,
                      Icons.send_outlined,
                      'Share',
                      () => _showSnackBar(context, 'Shared post $postNumber'),
                    ),
                    const Spacer(),
                    _buildIconButton(
                      context,
                      Icons.bookmark_border,
                      'Save',
                      () => _showSnackBar(context, 'Saved post $postNumber'),
                    ),
                  ],
                ),
                SizedBox(
                  height: ResponsiveHelper.verticalPadding(context) / 2,
                ),
                // Likes count
                Text(
                  '${1250 + postNumber * 100} likes',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getBodySmall(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: ResponsiveHelper.verticalPadding(context) / 4,
                ),
                // Caption
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getBodySmall(context),
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'user_name_$postNumber ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                            'Amazing view! 🌅 Love spending time in nature. #travel #photography',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ResponsiveHelper.verticalPadding(context) / 4,
                ),
                // View comments
                Text(
                  'View all ${postNumber * 50} comments',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getBodySmall(context),
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper method to build icon buttons with responsive sizing
  Widget _buildIconButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return Tooltip(
      message: label,
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        iconSize: ResponsiveHelper.getIconSize(context),
        // Ensure minimum touch target (48x48dp)
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      ),
    );
  }

  /// Sidebar menu - visible on tablets
  Widget _buildSidebarMenu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ResponsiveHelper.verticalPadding(context)),
        _buildSidebarMenuItem(
          context,
          Icons.home,
          'Home',
          () => _showSnackBar(context, 'Home tapped'),
        ),
        _buildSidebarMenuItem(
          context,
          Icons.search,
          'Explore',
          () => _showSnackBar(context, 'Explore tapped'),
        ),
        _buildSidebarMenuItem(
          context,
          Icons.favorite_border,
          'Likes',
          () => _showSnackBar(context, 'Likes tapped'),
        ),
        _buildSidebarMenuItem(
          context,
          Icons.message_outlined,
          'Messages',
          () => _showSnackBar(context, 'Messages tapped'),
        ),
        _buildSidebarMenuItem(
          context,
          Icons.bookmark_border,
          'Saved',
          () => _showSnackBar(context, 'Saved tapped'),
        ),
        _buildSidebarMenuItem(
          context,
          Icons.person,
          'Profile',
          () => _showSnackBar(context, 'Profile tapped'),
        ),
      ],
    );
  }

  /// Sidebar menu item
  Widget _buildSidebarMenuItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveHelper.verticalPadding(context) / 4,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.all(
              ResponsiveHelper.horizontalPadding(context) / 2,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.black87,
                  size: ResponsiveHelper.getIconSize(context),
                ),
                SizedBox(width: ResponsiveHelper.horizontalPadding(context) / 2),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getBodyMedium(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Suggested users section - right sidebar on landscape
  Widget _buildSuggestedUsers(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        ResponsiveHelper.horizontalPadding(context) / 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Suggested for you',
            style: TextStyle(
              fontSize: ResponsiveHelper.getBodyMedium(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: ResponsiveHelper.verticalPadding(context)),
          ...List.generate(
            5,
            (index) => Padding(
              padding: EdgeInsets.only(
                bottom: ResponsiveHelper.verticalPadding(context) / 2,
              ),
              child: Row(
                children: [
                  Container(
                    width: ResponsiveHelper.getResponsiveSize(
                      context,
                      mobile: 32,
                      tablet: 40,
                    ),
                    height: ResponsiveHelper.getResponsiveSize(
                      context,
                      mobile: 32,
                      tablet: 40,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.pink, width: 1),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        color: Colors.grey[600],
                        size: ResponsiveHelper.getResponsiveSize(
                          context,
                          mobile: 16,
                          tablet: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ResponsiveHelper.horizontalPadding(context) / 3,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'user_${index + 1}',
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getBodySmall(context),
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Followed by friends',
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getCaptionSize(context),
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Bottom navigation bar - adaptive
  Widget _buildBottomBar(BuildContext context) {
    final isTablet = ResponsiveHelper.isTablet(context);

    // Hide bottom bar on tablets (use sidebar instead)
    if (isTablet) {
      return const SizedBox.shrink();
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 8,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.search),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.add_box_outlined),
          label: 'Post',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite_border),
          label: 'Likes',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        final labels = ['Home', 'Explore', 'Post', 'Likes', 'Profile'];
        _showSnackBar(context, '${labels[index]} tapped');
      },
    );
  }

  /// Floating action button - only on mobile
  Widget _buildFAB(BuildContext context) {
    final isTablet = ResponsiveHelper.isTablet(context);

    if (isTablet) {
      return const SizedBox.shrink();
    }

    return FloatingActionButton(
      onPressed: () => _showSnackBar(context, 'Create new post'),
      backgroundColor: Colors.black,
      child: const Icon(Icons.add),
    );
  }

  /// Helper to show snackbar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
