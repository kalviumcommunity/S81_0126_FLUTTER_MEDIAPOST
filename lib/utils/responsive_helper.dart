import 'package:flutter/material.dart';

/// Responsive design utilities for handling different screen sizes
class ResponsiveHelper {
  /// Get device type based on screen width
  static DeviceType getDeviceType(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < 600) {
      return DeviceType.mobile;
    } else if (screenWidth < 1200) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Get responsive value based on device type
  static T getResponsiveValue<T>({
    required BuildContext context,
    required T mobile,
    required T tablet,
    required T desktop,
  }) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet;
      case DeviceType.desktop:
        return desktop;
    }
  }

  /// Get responsive font size
  static double getResponsiveFontSize(
    BuildContext context, {
    required double mobileSize,
    required double tabletSize,
    required double desktopSize,
  }) {
    return getResponsiveValue(
      context: context,
      mobile: mobileSize,
      tablet: tabletSize,
      desktop: desktopSize,
    );
  }

  /// Get responsive padding
  static EdgeInsets getResponsivePadding(
    BuildContext context, {
    required double mobilePadding,
    required double tabletPadding,
    required double desktopPadding,
  }) {
    final padding = getResponsiveValue(
      context: context,
      mobile: mobilePadding,
      tablet: tabletPadding,
      desktop: desktopPadding,
    );
    return EdgeInsets.all(padding);
  }

  /// Get responsive width (max width for content)
  static double getResponsiveMaxWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobile:
        return screenWidth * 0.95; // 95% of screen
      case DeviceType.tablet:
        return screenWidth * 0.85; // 85% of screen
      case DeviceType.desktop:
        return 1200; // Fixed max width for desktop
    }
  }

  /// Get responsive grid columns
  static int getResponsiveGridColumns(BuildContext context) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobile:
        return 1; // Single column
      case DeviceType.tablet:
        return 2; // Two columns
      case DeviceType.desktop:
        return 3; // Three columns
    }
  }

  /// Check if device is mobile
  static bool isMobile(BuildContext context) {
    return getDeviceType(context) == DeviceType.mobile;
  }

  /// Check if device is tablet
  static bool isTablet(BuildContext context) {
    return getDeviceType(context) == DeviceType.tablet;
  }

  /// Check if device is desktop
  static bool isDesktop(BuildContext context) {
    return getDeviceType(context) == DeviceType.desktop;
  }

  /// Check if in landscape orientation
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Check if in portrait orientation
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// Get safe area padding (for notches, etc.)
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Get screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get device pixel ratio (for high-res screens)
  static double getDevicePixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }
}

/// Device type enumeration
enum DeviceType {
  mobile,  // < 600px
  tablet,  // 600px - 1200px
  desktop, // > 1200px
}

/// Design system constants for responsive layouts
class DesignSystem {
  // Breakpoints
  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 1200;

  // Spacing (8px grid system)
  static const double spacing2xs = 4;
  static const double spacingXs = 8;
  static const double spacingSm = 12;
  static const double spacingMd = 16;
  static const double spacingLg = 24;
  static const double spacingXl = 32;
  static const double spacing2xl = 48;

  // Border radius
  static const double radiusSm = 4;
  static const double radiusMd = 8;
  static const double radiusLg = 12;
  static const double radiusXl = 16;

  // Shadow
  static const BoxShadow shadowSm = BoxShadow(
    color: Color(0x1F000000),
    blurRadius: 2,
    offset: Offset(0, 1),
  );

  static const BoxShadow shadowMd = BoxShadow(
    color: Color(0x19000000),
    blurRadius: 6,
    offset: Offset(0, 3),
  );

  static const BoxShadow shadowLg = BoxShadow(
    color: Color(0x0F000000),
    blurRadius: 12,
    offset: Offset(0, 6),
  );
}

/// Responsive text widgets
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? baseStyle;
  final TextAlign? textAlign;

  const ResponsiveText(
    this.text, {
    this.baseStyle,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: baseStyle,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}

/// Responsive spacer widget
class ResponsiveSpacer extends StatelessWidget {
  final double mobileHeight;
  final double tabletHeight;
  final double desktopHeight;

  const ResponsiveSpacer({
    this.mobileHeight = 16,
    this.tabletHeight = 24,
    this.desktopHeight = 32,
  });

  @override
  Widget build(BuildContext context) {
    final height = ResponsiveHelper.getResponsiveValue(
      context: context,
      mobile: mobileHeight,
      tablet: tabletHeight,
      desktop: desktopHeight,
    );
    return SizedBox(height: height);
  }
}

/// Responsive container with max width
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? backgroundColor;

  const ResponsiveContainer({
    required this.child,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: ResponsiveHelper.getResponsiveMaxWidth(context),
        padding: padding,
        color: backgroundColor,
        child: child,
      ),
    );
  }
}

/// Responsive grid view
class ResponsiveGridView extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;
  final double spacing;

  const ResponsiveGridView({
    required this.children,
    this.padding,
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveHelper.getResponsiveGridColumns(context);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      padding: padding,
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}
