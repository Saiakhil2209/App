import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/post_service.dart';
import '../../../shared/models/post_model.dart';
import '../widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  final String spaceId;
  final String spaceType;

  const FeedScreen({
    super.key,
    required this.spaceId,
    required this.spaceType,
  });

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<PostModel> _posts = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  @override
  void didUpdateWidget(FeedScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.spaceId != widget.spaceId) {
      _loadPosts();
    }
  }

  Future<void> _loadPosts() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      List<PostModel> posts = [];

      switch (widget.spaceType) {
        case 'cohort':
          posts = await PostService.getCohortFeed(widget.spaceId);
          break;
        case 'alumni':
        case 'college':
          posts = await PostService.getCollegeFeed(widget.spaceId);
          break;
        case 'trending':
          posts = await PostService.getTrendingFeed();
          break;
        case 'global':
          posts = await PostService.getGlobalFeed();
          break;
        case 'wall':
          posts = await PostService.getWallFeed();
          break;
        default:
          posts = await PostService.getGlobalFeed();
      }

      if (mounted) setState(() => _posts = posts);
    } catch (e) {
      if (mounted) setState(() => _hasError = true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppTheme.primary),
      );
    }

    if (_hasError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Something went wrong',
                style: TextStyle(color: AppTheme.textMuted)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loadPosts,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_posts.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🚀',
                style: TextStyle(fontSize: 40)),
            const SizedBox(height: 12),
            const Text('No posts yet',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary)),
            const SizedBox(height: 6),
            const Text('Be the first to post here!',
                style: TextStyle(fontSize: 13, color: AppTheme.textMuted)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/post/create'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(160, 44),
              ),
              child: const Text('Create First Post'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: AppTheme.primary,
      onRefresh: _loadPosts,
      child: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: _posts.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          return PostCard(post: _posts[index]);
        },
      ),
    );
  }
}