import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(const RpgMobileApp());
}
class RpgMobileApp extends StatelessWidget {
  const RpgMobileApp({super.key});

@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'RPG Mobile 2026',
    theme: ThemeData(useMaterial3: true),
    home: const HomeScreen(),
    );
  }
}
