import 'package:fav_route/models/place.dart';
import 'package:flutter/material.dart';

class AddPlaceSheet extends StatefulWidget {
  static Future<Place?>? show(BuildContext context, {Place? initial}) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        // Needed for full-height sheets
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) => AddPlaceSheet._(initial: initial),
      );

  final Place? initial;

  const AddPlaceSheet._({super.key, this.initial});

  @override
  State<AddPlaceSheet> createState() => _AddPlaceSheetState();
}

class _AddPlaceSheetState extends State<AddPlaceSheet> {
  late final _titleController =
      TextEditingController(text: widget.initial?.name);
  late final _addressController =
      TextEditingController(text: widget.initial?.address);
  late final _noteController =
      TextEditingController(text: widget.initial?.note);
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (s) => (s == null || s.isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
              validator: (s) => (s == null || s.isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: 'Note'),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _onSave,
              child: Text(widget.initial == null ? 'Add' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;

    final place = Place(
      id: widget.initial?.id ?? DateTime.now().millisecondsSinceEpoch,
      name: _titleController.text.trim(),
      address: _addressController.text.trim(),
      note: _noteController.text.trim(),
    );

    Navigator.of(context).pop(place);
  }
}
