import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Theme Showcase Screen - Demonstrates all colors, typography, and components
class ThemeShowcaseScreen extends StatelessWidget {
  const ThemeShowcaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme & Styling System'),
        backgroundColor: AppColors.surface,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ============ COLORS SECTION ============
              _buildSection(
                title: 'Color Palette',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildColorTile('Primary', AppColors.primary),
                    _buildColorTile('Secondary', AppColors.secondary),
                    _buildColorTile('Tertiary', AppColors.tertiary),
                    _buildColorTile('Success', AppColors.success),
                    _buildColorTile('Error', AppColors.error),
                    _buildColorTile('Warning', AppColors.warning),
                    _buildColorTile('Info', AppColors.info),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ============ GRADIENTS SECTION ============
              _buildSection(
                title: 'Gradients',
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: AppColors.instagramGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Instagram Gradient',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: AppColors.richGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Rich Gradient',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ============ TYPOGRAPHY SECTION ============
              _buildSection(
                title: 'Typography',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTypographyExample('Display Large', AppTypography.displayLarge),
                    _buildTypographyExample('Headline Large', AppTypography.headlineLarge),
                    _buildTypographyExample('Title Large', AppTypography.titleLarge),
                    _buildTypographyExample('Body Large', AppTypography.bodyLarge),
                    _buildTypographyExample('Label Large', AppTypography.labelLarge),
                    _buildTypographyExample('Caption', AppTypography.caption),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ============ BUTTONS SECTION ============
              _buildSection(
                title: 'Buttons',
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Elevated Button'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('Outlined Button'),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Text Button'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ============ CARDS SECTION ============
              _buildSection(
                title: 'Cards & Surfaces',
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Card Title',
                              style: AppTypography.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'This is a card with default surface color and subtle elevation.',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Alternative Surface',
                        style: AppTypography.bodyLarge.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ============ CHIPS & TAGS SECTION ============
              _buildSection(
                title: 'Chips & Tags',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(label: const Text('Design')),
                    Chip(label: const Text('Flutter')),
                    Chip(label: const Text('UI')),
                    Chip(
                      label: const Text('Selected'),
                      backgroundColor: AppColors.primary,
                      labelStyle: AppTypography.labelMedium.copyWith(
                        color: AppColors.textOnDark,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ============ INPUT FIELDS SECTION ============
              _buildSection(
                title: 'Input Fields',
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Text input with hint',
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Text input with label',
                        suffixIcon: const Icon(Icons.clear),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Error input',
                        errorText: 'This field is required',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ============ COLOR SWATCHES SECTION ============
              _buildSection(
                title: 'Color Swatches',
                child: Column(
                  children: [
                    _buildColorSwatch('Primary Swatch', AppColors.primarySwatch),
                    const SizedBox(height: 16),
                    _buildColorSwatch('Secondary Swatch', AppColors.secondarySwatch),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ============ STATUS INDICATORS SECTION ============
              _buildSection(
                title: 'Status Indicators',
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _buildStatusIndicator('Online', AppColors.online),
                    _buildStatusIndicator('Away', AppColors.away),
                    _buildStatusIndicator('Verified', AppColors.verified),
                    _buildStatusIndicator('Like', AppColors.like),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.headlineSmall,
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildColorTile(String name, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.borderLight,
                width: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTypography.titleMedium,
                ),
                Text(
                  '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypographyExample(String name, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: AppTypography.caption),
          const SizedBox(height: 4),
          Text(
            'The quick brown fox jumps over the lazy dog',
            style: style.copyWith(color: AppColors.textPrimary),
          ),
          const Divider(height: 16),
        ],
      ),
    );
  }

  Widget _buildColorSwatch(
    String name,
    Map<int, Color> swatch,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: AppTypography.titleMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 4,
          children: swatch.entries.map((entry) {
            return Tooltip(
              message: '${entry.key}',
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: entry.value,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: AppColors.borderLight,
                    width: 0.5,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStatusIndicator(String label, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTypography.caption,
        ),
      ],
    );
  }
}
