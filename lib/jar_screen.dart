import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'memory_store.dart';

class JarScreen extends StatefulWidget {
  const JarScreen({super.key});

  @override
  State<JarScreen> createState() => _JarScreenState();
}

class _JarScreenState extends State<JarScreen> {
  List<Memory>? _memories;

  static const _colors = [
    Color(0xFFF4A261),
    Color(0xFF90BE6D),
    Color(0xFF8ECAE6),
    Color(0xFFE5989B),
    Color(0xFFB5A7E8),
    Color(0xFFF9C74F),
  ];

  @override
  void initState() {
    super.initState();
    MemoryStore.loadAll().then((m) {
      if (mounted) setState(() => _memories = m);
    });
  }

  void _show(Memory m) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(m.date),
        content: Text(m.text),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final memories = _memories;
    if (memories == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (memories.isEmpty) {
      return const Center(child: Text('Your jar is empty. Add a memory!'));
    }

    const cols = 7;
    const gap = 34.0;
    const rowH = 30.0;
    final rows = (memories.length / cols).ceil();
    final jarHeight = math.max(340.0, rows * rowH + 30);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text('${memories.length} memories',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          Container(
            width: 260,
            height: jarHeight,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.outline, width: 3),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(48),
                bottomRight: Radius.circular(48),
              ),
            ),
            child: Stack(
              children: List.generate(memories.length, (i) {
                final col = i % cols;
                final row = i ~/ cols;
                final ms = 500 + math.min(i, 20) * 50;
                return Positioned(
                  left: 8 + col * gap + (row.isOdd ? 8 : 0),
                  bottom: 8 + row * rowH,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: Duration(milliseconds: ms),
                    curve: Curves.bounceOut,
                    builder: (_, v, child) => Opacity(
                      opacity: v.clamp(0.0, 1.0),
                      child: Transform.translate(
                        offset: Offset(0, -(1 - v) * 200),
                        child: child,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () => _show(memories[i]),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: _colors[i % _colors.length],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}