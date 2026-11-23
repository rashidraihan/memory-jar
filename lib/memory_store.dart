import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Memory {
  final String date; // like 2026-11-23
  final String text;
  Memory(this.date, this.text);

  Map<String, String> toJson() => {'date': date, 'text': text};
  factory Memory.fromJson(Map<String, dynamic> j) =>
      Memory(j['date'], j['text']);
}

class MemoryStore {
  static const _key = 'memories';

  static String todayKey() {
    final n = DateTime.now();
    final m = n.month.toString().padLeft(2, '0');
    final d = n.day.toString().padLeft(2, '0');
    return '${n.year}-$m-$d';
  }

  static Future<List<Memory>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List;
    return list.map((e) => Memory.fromJson(e)).toList();
  }

  // Returns false if today already has a memory.
  static Future<bool> add(String text) async {
    final all = await loadAll();
    final today = todayKey();
    if (all.any((m) => m.date == today)) return false;
    all.add(Memory(today, text));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _key, jsonEncode(all.map((m) => m.toJson()).toList()));
    return true;
  }
}