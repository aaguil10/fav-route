import 'package:fav_route/ui/blocs/place_bloc/place_bloc.dart';
import 'package:fav_route/ui/blocs/place_bloc/place_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Represents the two tabs in the bottom navigation.
enum NavTab { favorites, saved }

class ScaffoldWithBottomNav extends StatelessWidget {
  final Widget child;

  const ScaffoldWithBottomNav({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final selectedTab = _tabForLocation(location);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: _AppBarTitle(selectedTab: selectedTab),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: _navItems,
        currentIndex: selectedTab.index,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: (index) => _onTabSelected(context, NavTab.values[index]),
      ),
    );
  }

  NavTab _tabForLocation(String location) {
    return location.startsWith('/lists') ? NavTab.saved : NavTab.favorites;
  }

  void _onTabSelected(BuildContext context, NavTab tab) {
    switch (tab) {
      case NavTab.favorites:
        final listId = context.read<PlaceBloc>().state.placeList?.id;
        context.go('/list/$listId');
        break;
      case NavTab.saved:
        context.go('/lists');
        break;
    }
  }

  static const List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Saved'),
  ];
}

class _AppBarTitle extends StatelessWidget {
  final NavTab selectedTab;

  const _AppBarTitle({required this.selectedTab, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedTab == NavTab.saved) {
      return const Text('Saved Lists');
    }

    final state = context.select((PlaceBloc bloc) => bloc.state);
    if (state is PlacesLoaded) {
      return Text(state.placeList?.name ?? '');
    }

    return const SizedBox.shrink();
  }
}
