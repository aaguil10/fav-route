import 'package:fav_route/models/place.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'main.dart';

class AddPlaceSheet extends StatefulWidget {
  static showAddPlaceSheet(BuildContext context) => showModalBottomSheet(
        context: rootNavigatorKey.currentContext!,
        useRootNavigator: true,
        // Needed for full-height sheets
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) => const AddPlaceSheet(),
      );

  const AddPlaceSheet({super.key});

  @override
  State<AddPlaceSheet> createState() => _AddPlaceSheetState();
}

class _AddPlaceSheetState extends State<AddPlaceSheet> {
  final _titleController = TextEditingController();
  final _addressController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _addressController,
            decoration: const InputDecoration(labelText: 'Address'),
          ),
          TextField(
            controller: _noteController,
            decoration: const InputDecoration(labelText: 'Note'),
          ),
          TextButton(
            onPressed: () {
              context.pop(Place(
                      id: 0,
                      name: _titleController.text,
                      address: _addressController.text,
                      note: _noteController.text)
                  .toJsonString());
            },
            child: const Text('save'),
          ),
        ],
      ),
    );
  }

  String? _validTitle(String? text) {
    if (text?.trim().isNotEmpty ?? false) return text?.trim();
    return null;
  }
}
