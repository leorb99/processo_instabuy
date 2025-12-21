import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  final Future<Map<String, String>> categoriesFuture;

  const MenuItems({super.key, required this.categoriesFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final categories = snapshot.data!;
          return ListView(
            padding: EdgeInsets.zero,
            children: categories.entries.map((entry) {
              return ListTile(
                title: Text(entry.value),
                onTap: () {
                  // TODO: navegacao entre as categorias
                },
              );
            }).toList(),
          );
        } else {
          return const Text('Erro ao carregar categorias.');
        }
      },
    );
  }
}