import 'package:fav_route/data/models/place.dart';
import 'package:fav_route/data/repositories/place_service.dart';
import 'package:fav_route/ui/blocs/place_list_bloc/place_list_bloc.dart';
import 'package:fav_route/ui/blocs/place_list_bloc/place_list_event.dart';
import 'package:fav_route/ui/blocs/place_list_bloc/place_list_state.dart';
import 'package:fav_route/ui/widgets/add_place_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceListPage extends StatelessWidget {
  static const title = 'Favorites';

  const PlaceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            PlaceListBloc(RepositoryProvider.of<PlaceService>(context))
              ..add(LoadPlaceList()),
        child: BlocBuilder<PlaceListBloc, PlaceListState>(
            builder: (context, state) {
          if (state is PlacesLoading) {
            return Center(child: _buildAddButton(context));
          }
          return Column(
            children: [
              Expanded(child: _buildPlaceList((state as PlacesLoaded).places)),
              _buildAddButton(context),
            ],
          );
        }));
  }

  Widget _buildPlaceList(List<Place> places) {
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(places[index].name ?? ''),
          subtitle: Text(places[index].address ?? ''),
          onTap: () async {
            final place =
                await AddPlaceSheet.show(context, initial: places[index]);
            if (place != null) {
              context.read<PlaceListBloc>().add(UpdatePlaceList(place));
            }
          },
        );
      },
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () async {
        final place = await AddPlaceSheet.show(context);
        if (place != null) {
          context.read<PlaceListBloc>().add(AddPlaceList(place));
        }
      },
    );
  }
}
