import 'package:flutter/material.dart';
import 'add_memory_screen.dart';
import 'jar_screen.dart';
import 'morning_screen.dart';

void main() {
  runApp(const MemoryJarApp());
}

class MemoryJarApp extends StatelessWidget {
  const MemoryJarApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF7FB7A4); // calm sage green
    return MaterialApp(
      title: 'Memory Jar',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // follows phone light/dark setting
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: seed, brightness: Brightness.dark),
      ),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const _titles = ['Add Memory', 'Jar', 'Morning Memory'];

  @override
  Widget build(BuildContext context) {
    // Screens are rebuilt on each tab switch, so they always show fresh data.
    final screens = [
      const AddMemoryScreen(),
      const JarScreen(),
      const MorningScreen(),
    ];
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_index])),
      body: SafeArea(child: screens[_index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.edit), label: 'Add'),
          NavigationDestination(icon: Icon(Icons.local_drink), label: 'Jar'),
          NavigationDestination(
              icon: Icon(Icons.wb_sunny), label: 'Morning'),
        ],
      ),
    );
  }
}