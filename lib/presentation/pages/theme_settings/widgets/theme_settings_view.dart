import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/theme/theme_bloc.dart';
import '../../../blocs/theme/theme_event.dart';
import '../../../blocs/theme/theme_state.dart';
import 'action_buttons_card.dart';
import 'app_theme_card.dart';
import 'common/loading_overlay.dart';
import 'font_settings_card.dart';
import 'language_card.dart';
import 'preview_card.dart';
import 'theme_mode_card.dart';

/// Main content view for theme settings with all configuration sections
class ThemeSettingsView extends StatefulWidget {
  const ThemeSettingsView({super.key});

  @override
  State<ThemeSettingsView> createState() => _ThemeSettingsViewState();
}

class _ThemeSettingsViewState extends State<ThemeSettingsView>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();

    // Load theme data if not already loaded
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final state = context.read<ThemeBloc>().state;
      if (state is! ThemeLoaded) {
        context.read<ThemeBloc>().add(const ThemeLoadCurrentEvent());
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.8, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1, curve: Curves.easeOutCubic),
      ),
    );

    // Start the animation
    unawaited(_animationController.forward());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state is ThemeInitial || state is ThemeLoading) {
          return _buildLoadingState(context);
        }

        if (state is ThemeError && state.previousState == null) {
          return _buildErrorState(context, state);
        }

        // Extract theme state from various state types
        final ThemeLoaded themeState;
        final bool isLoading;

        if (state is ThemeLoaded) {
          themeState = state;
          isLoading = false;
        } else if (state is ThemeOperationInProgress &&
            state.previousState != null) {
          themeState = state.previousState!;
          isLoading = true;
        } else if (state is ThemeOperationSuccess) {
          themeState = state.updatedState;
          isLoading = false;
        } else if (state is ThemeError && state.previousState != null) {
          themeState = state.previousState!;
          isLoading = false;
        } else {
          return _buildErrorState(context, null);
        }

        return Stack(
          children: [
            _buildContent(context, themeState, isLoading),
            if (isLoading) const LoadingOverlay(),
          ],
        );
      },
    );
  }

  /// Builds the loading state
  Widget _buildLoadingState(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading theme settings...'),
          ],
        ),
      ),
    );
  }

  /// Builds the error state
  Widget _buildErrorState(BuildContext context, ThemeError? error) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              error?.message ?? 'Unable to load theme settings',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                context.read<ThemeBloc>().add(const ThemeLoadCurrentEvent());
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the main content with all settings sections
  Widget _buildContent(
    BuildContext context,
    ThemeLoaded themeState,
    bool isLoading,
  ) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: child,
          ),
        );
      },
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<ThemeBloc>().add(const ThemeLoadCurrentEvent());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Theme Mode Section
              ThemeModeCard(
                themeState: themeState,
                isLoading: isLoading,
              ),
              const SizedBox(height: 16),

              // Font Settings Section
              FontSettingsCard(
                themeState: themeState,
                isLoading: isLoading,
              ),
              const SizedBox(height: 16),

              // App Theme Section
              AppThemeCard(
                themeState: themeState,
                isLoading: isLoading,
              ),
              const SizedBox(height: 16),

              // Language Section
              const LanguageCard(),
              const SizedBox(height: 16),

              // Preview Section
              PreviewCard(
                themeState: themeState,
              ),
              const SizedBox(height: 16),

              // Action Buttons Section
              ActionButtonsCard(
                themeState: themeState,
                isLoading: isLoading,
              ),

              // Bottom padding for better scrolling
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
