import 'package:fav_route/data/models/place_model.dart';
import 'package:fav_route/ui/blocs/place_bloc/place_bloc.dart';
import 'package:fav_route/ui/blocs/place_bloc/place_event.dart';
import 'package:fav_route/ui/blocs/place_bloc/place_state.dart';
import 'package:fav_route/ui/widgets/add_place_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceListPage extends StatelessWidget {
  const PlaceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceBloc, PlaceState>(builder: (context, state) {
      if (state is PlacesLoading || state is PlacesInitial) {
        return const Center(child: CircularProgressIndicator());
      }
      return Column(
        children: [
          Expanded(child: _buildPlaceList((state as PlacesLoaded).places)),
          _buildAddButton(context),
        ],
      );
    });
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
              final placeList = context.read<PlaceBloc>().state.placeList;
              if (!place.placeListIds.contains(placeList?.id)) {
                place.placeListIds.add(placeList!.id);
              }
              context
                  .read<PlaceBloc>()
                  .add(UpdatePlace(placeList: placeList!, place: place));
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
          final placeList = context.read<PlaceBloc>().state.placeList;
          if (!place.placeListIds.contains(placeList?.id)) {
            place.placeListIds.add(placeList!.id);
          }
          context
              .read<PlaceBloc>()
              .add(AddPlace(placeList: placeList!, place: place));
        }
      },
    );
  }
}
