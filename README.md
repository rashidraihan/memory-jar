<h1 align="center">Memory Jar ✧</h1>

<p align="center"><i>One good thing a day. One little light in the jar. (´• ω •`)</i></p>

<p align="center">
  <a href="https://github.com/rashidraihan/memory-jar/releases/latest">
    <img src="https://img.shields.io/badge/Download-APK-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Download APK">
  </a>
</p>

---

## What is this?

Every day, write one good thing that happened. It drops into your jar as a glowing dot. Every morning, the app shows you a random memory from your past. 

Everything stays on your phone. No accounts, no internet, no ads.

## How to install (Android)

1. Tap the green button above
2. Download `memory-jar.apk`
3. Open it and allow "install unknown apps"

## How the code is organized

| File | Its job |
|------|---------|
| `lib/main.dart` | Starts the app, colors, bottom bar |
| `lib/memory_store.dart` | Saves and loads memories on the phone |
| `lib/add_memory_screen.dart` | Add Memory screen |
| `lib/jar_screen.dart` | Jar screen with falling dots |
| `lib/morning_screen.dart` | Morning Memory screen |
| `.github/workflows/build.yml` | Tells GitHub how to build the APK |
| `scripts/make_icon.py` | Draws the app icon |

## Built with

Flutter + GitHub Actions. Free and open source (MIT license). (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧