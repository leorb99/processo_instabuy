import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('cat1'),
          tileColor: Colors.amber,
          onTap: () {
          },
        ),
        ListTile(
          title: Text('cat2'),
          tileColor: Colors.amber[900],
          onTap: () {
          },
        ),
      ],
    );
  }
}