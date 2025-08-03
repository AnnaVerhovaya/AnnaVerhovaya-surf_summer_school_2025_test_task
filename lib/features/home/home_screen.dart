import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../core/core.dart';
import '../../uikit/uikit.dart';
import '../favorites/presentation/presentation.dart';
import '../map/presentation/screens/map_screen.dart';
import '../places/presentation/presentation.dart';
import '../settings/presentation/screens/settings_screen.dart'
    show SettingsScreen;

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const PlacesListScreen(),
    MapScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: SvgPictureWidget(AppSvgIcons.icListFull),
            activeIcon: SvgPictureWidget(AppSvgIcons.icListFull),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPictureWidget(AppSvgIcons.icMap),
            activeIcon: SvgPictureWidget(AppSvgIcons.icMapFull),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPictureWidget(AppSvgIcons.icHeart),
            activeIcon: SvgPictureWidget(AppSvgIcons.icHeartFull),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPictureWidget(AppSvgIcons.icSettings),
            activeIcon: SvgPictureWidget(AppSvgIcons.icSettingsFull),
            label: "",
          ),
        ],
      ),
    );
  }
}
