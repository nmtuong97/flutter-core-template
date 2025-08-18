import 'package:flutter/material.dart';
import '../../l10n/l10n.dart';

class LayoutComponentPage extends StatelessWidget {
  const LayoutComponentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.rowExample),
          const SizedBox(height: 8),
          Container(
            color: Colors.blue.shade100,
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.star),
                Text('${context.l10n.item} 1'),
                const Icon(Icons.star),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(context.l10n.columnExample),
          const SizedBox(height: 8),
          Container(
            color: Colors.green.shade100,
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${context.l10n.item} A'),
                const SizedBox(height: 4),
                Text('${context.l10n.item} B'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(context.l10n.stackExample),
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
                Positioned(
                  top: 10,
                  left: 10,
                  child: Text('${context.l10n.layer} 1'),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Text('${context.l10n.layer} 2'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(context.l10n.expandedFlexibleExample),
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
                    child: Center(child: Text(context.l10n.expanded)),
                  ),
                ),
                Flexible(
                  child: Container(
                    height: 50,
                    color: Colors.purple.shade700,
                    child: Center(child: Text(context.l10n.flexible)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(context.l10n.paddingExample),
          const SizedBox(height: 8),
          ColoredBox(
            color: Colors.orange.shade100,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(context.l10n.paddedContent),
            ),
          ),
          const SizedBox(height: 16),
          Text(context.l10n.alignExample),
          const SizedBox(height: 8),
          Container(
            width: 200,
            height: 100,
            color: Colors.teal.shade100,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(context.l10n.bottomRight),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
