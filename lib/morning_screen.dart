import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'memory_store.dart';

class MorningScreen extends StatefulWidget {
  const MorningScreen({super.key});

  @override
  State<MorningScreen> createState() => _MorningScreenState();
}

class _MorningScreenState extends State<MorningScreen> {
  List<Memory>? _memories;
  Memory? _picked;

  @override
  void initState() {
    super.initState();
    MemoryStore.loadAll().then((all) {
      if (!mounted) return;
      setState(() {
        _memories = all;
        _pick();
      });
    });
  }

  void _pick() {
    final all = _memories;
    if (all == null || all.isEmpty) return;
    // Prefer a past memory (not today's), if one exists.
    final past = all.where((m) => m.date != MemoryStore.todayKey()).toList();
    final pool = past.isNotEmpty ? past : all;
    _picked = pool[math.Random().nextInt(pool.length)];
  }

  @override
  Widget build(BuildContext context) {
    if (_memories == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final m = _picked;
    if (m == null) {
      return const Center(
        child: Text('No memories yet.\nAdd one and come back tomorrow.',
            textAlign: TextAlign.center),
      );
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Good morning ☀️',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(m.date,
                        style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(height: 12),
                    Text(m.text,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => setState(_pick),
              child: const Text('Show another'),
            ),
          ],
        ),
      ),
    );
  }
}