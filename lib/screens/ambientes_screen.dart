import 'package:flutter/material.dart';
import '../data/ambientes_mock.dart';
import 'ambiente_detalhes.dart';
import '../models/ambiente.dart';

class AmbientesScreen extends StatelessWidget {

  const AmbientesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ambientes do Jogo')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: ambientesMock.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final amb = ambientesMock[index];
          return _AmbienteCard(ambiente: amb);
        },
      ),
    );
  }
}

class _AmbienteCard extends StatelessWidget {
  final Ambiente ambiente;

  const _AmbienteCard({required this.ambiente});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AmbienteDetalheScreen(ambiente: ambiente),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            ambiente.nome,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
