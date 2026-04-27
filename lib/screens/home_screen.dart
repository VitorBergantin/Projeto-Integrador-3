import 'package:flutter/material.dart';
import 'package:projeto_integrador_3/screens/mapa_page.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invasão da PUC!')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '🛠️ Ainda desenvolvendo cadastro 🛠️',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 30),

            FilledButton.icon(
              label: const Text('Avançar'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MapaPage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}