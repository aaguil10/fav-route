import 'package:fav_route/ui/pages/favorites_page.dart';
import 'package:fav_route/ui/pages/lists_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithBottomNav extends StatelessWidget {
  final Widget child;

  const ScaffoldWithBottomNav({required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final selectedIndex = location.startsWith('/favorites') ? 0 : 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_getTitle(context, selectedIndex)),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Lists"),
        ],
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: selectedIndex,
        onTap: (index) => _changeTab(context, index),
      ),
    );
  }

  String _getTitle(BuildContext context, int index) {
    switch (index) {
      case 0:
        return FavoritesPage.title;
      case 1:
        return ListsPage.title;
      default:
        return FavoritesPage.title;
    }
  }

  void _changeTab(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/favorites');
        break;
      case 1:
        context.go('/lists');
        break;
    }
  }
}
