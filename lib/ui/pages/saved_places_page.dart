import 'package:flutter/material.dart';

class SavedPlacesPage extends StatefulWidget {
  static const title = 'Collections';

  const SavedPlacesPage({super.key});

  @override
  State<SavedPlacesPage> createState() => _SavedPlacesPageState();
}

class _SavedPlacesPageState extends State<SavedPlacesPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Lists Page'),
    );
  }
}
