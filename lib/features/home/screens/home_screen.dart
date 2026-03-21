import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/app_drawer.dart';
import '../widgets/inner_tab_bar.dart';
import '../../feed/screens/feed_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _activeSpaceId = 'cohort';
  String _activeSpaceName = 'KITS Warangal 2026';
  String _activeSpaceSub = '142 members · your cohort';
  int _innerTabIndex = 0;

  final List<String> _innerTabs = ['Posts', 'Referrals', 'Members'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgSecondary,
      appBar: AppBar(
        backgroundColor: AppTheme.bgPrimary,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: AppTheme.textSecondary),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'Intouch',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppTheme.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 20),
            color: AppTheme.textMuted,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, size: 20),
            color: AppTheme.textMuted,
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: AppTheme.primaryLight,
              child: Text(
                'SA',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(
        userName: 'Sai Akhil',
        userSub: 'KITS Warangal · 2026 passout',
        initials: 'SA',
        walledByYouCount: 18,
        walledYouCount: 34,
        activeSpaceId: _activeSpaceId,
        onSpaceSelected: (id, name, sub) {
          setState(() {
            _activeSpaceId = id;
            _activeSpaceName = name;
            _activeSpaceSub = sub;
            _innerTabIndex = 0;
          });
        },
      ),
      body: Column(
        children: [
          // Space header
          Container(
            color: AppTheme.bgPrimary,
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _activeSpaceName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        _activeSpaceSub,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.textHint,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Inner tabs
          InnerTabBar(
            tabs: _innerTabs,
            selectedIndex: _innerTabIndex,
            onTabChanged: (i) => setState(() => _innerTabIndex = i),
          ),

          const Divider(height: 0.5),

          // Feed
          Expanded(
            child: FeedScreen(
              spaceId: _activeSpaceId,
              spaceType: _activeSpaceId,
            ),
          ),
        ],
      ),

      // FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}