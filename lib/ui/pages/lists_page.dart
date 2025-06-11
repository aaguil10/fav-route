import 'package:flutter/material.dart';

class ListsPage extends StatefulWidget {
  static const title = 'Collections';

  const ListsPage({super.key});

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Lists Page'),
    );
  }
}
