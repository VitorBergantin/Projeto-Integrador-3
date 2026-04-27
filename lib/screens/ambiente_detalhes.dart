import 'package:flutter/material.dart';
import '../models/ambiente.dart';

class AmbienteDetalheScreen extends StatelessWidget {
  final Ambiente ambiente;

  const AmbienteDetalheScreen({super.key, required this.ambiente});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ambiente.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ambiente.nome,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              ambiente.descricao,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            Text('Latitude: ${ambiente.latitude}'),
            Text('Longitude: ${ambiente.longitude}'),
            Text('Raio: ${ambiente.raioMetros}m'),
          ],
        ),
      ),
    );
  }
}