import 'package:fav_route/ui/blocs/place_bloc/place_bloc.dart';
import 'package:fav_route/ui/blocs/place_bloc/place_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithBottomNav extends StatelessWidget {
  final Widget child;

  const ScaffoldWithBottomNav({required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final selectedIndex = location.startsWith('/lists') ? 1 : 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: BlocBuilder<PlaceBloc, PlaceState>(
          builder: (context, state) {
            if (selectedIndex == 1) {
              return const Text('Saved Lists');
            }
            if (state is PlacesInitial) {
              return const Center(child: Text(''));
            }
            return Text(state.placeList?.name ?? '');
          },
        ),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Saved"),
        ],
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: selectedIndex,
        onTap: (index) => _changeTab(context, index),
      ),
    );
  }

  void _changeTab(BuildContext context, int index) {
    switch (index) {
      case 0:
        final listId = context.read<PlaceBloc>().placeListId;
        context.go('/list/$listId');
        break;
      case 1:
        context.go('/lists');
        break;
    }
  }
}
