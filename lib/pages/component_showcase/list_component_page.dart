import 'package:flutter/material.dart';

class ListComponentPage extends StatelessWidget {
  const ListComponentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ListView Example:'),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.list),
                  title: Text('Item ${index + 1}'),
                  subtitle: const Text('Description of item'),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          const Text('GridView Example:'),
          const SizedBox(height: 8),
          SizedBox(
            height: 300,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.teal.shade100,
                  child: Center(
                    child: Text('Grid Item ${index + 1}'),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}