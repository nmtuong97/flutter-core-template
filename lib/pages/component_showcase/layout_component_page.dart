import 'package:flutter/material.dart';

class LayoutComponentPage extends StatelessWidget {
  const LayoutComponentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Row Example:'),
          const SizedBox(height: 8),
          Container(
            color: Colors.blue.shade100,
            padding: const EdgeInsets.all(8),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.star),
                Text('Item 1'),
                Icon(Icons.star),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Column Example:'),
          const SizedBox(height: 8),
          Container(
            color: Colors.green.shade100,
            padding: const EdgeInsets.all(8),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Item A'),
                SizedBox(height: 4),
                Text('Item B'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Stack Example:'),
          const SizedBox(height: 8),
          SizedBox(
            width: 200,
            height: 100,
            child: Stack(
              children: [
                Container(
                  width: 200,
                  height: 100,
                  color: Colors.red.shade100,
                ),
                const Positioned(
                  top: 10,
                  left: 10,
                  child: Text('Layer 1'),
                ),
                const Positioned(
                  bottom: 10,
                  right: 10,
                  child: Text('Layer 2'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Expanded/Flexible Example:'),
          const SizedBox(height: 8),
          Container(
            color: Colors.purple.shade100,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.purple.shade300,
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.purple.shade500,
                    child: const Center(child: Text('Expanded')),
                  ),
                ),
                Flexible(
                  child: Container(
                    height: 50,
                    color: Colors.purple.shade700,
                    child: const Center(child: Text('Flexible')),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Padding Example:'),
          const SizedBox(height: 8),
          ColoredBox(
            color: Colors.orange.shade100,
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Text('Padded Content'),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Align Example:'),
          const SizedBox(height: 8),
          Container(
            width: 200,
            height: 100,
            color: Colors.teal.shade100,
            child: const Align(
              alignment: Alignment.bottomRight,
              child: Text('Bottom Right'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
