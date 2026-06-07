import 'package:flutter/material.dart';
import '../theme/game_theme.dart';

class CreditsScreen extends StatelessWidget {
  final String playerName;

  const CreditsScreen({super.key, required this.playerName});

  @override
  Widget build(BuildContext context) {
    final credits = [
      'INVASÃO DA PUC',
      '',
      'Projeto Integrador 3',
      'PUC Campinas',
      '',
      'Direção e desenvolvimento',
      playerName.isEmpty ? 'Equipe do Projeto' : playerName,
      '',
      'Roteiro',
      'A Jornada da PUC Paralela',
      '',
      'Arte, personagens e mapas',
      'Equipe do Projeto',
      '',
      'Programação e integração',
      'Equipe do Projeto',
      '',
      'Agradecimentos',
      'Professores, colegas e todos que testaram a aventura',
      '',
      'A PUC Paralela foi salva.',
      'Obrigado por jogar.',
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (final line in credits)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              line,
                              textAlign: TextAlign.center,
                              style: line == 'INVASÃO DA PUC'
                                  ? kTitleStyle.copyWith(fontSize: 22)
                                  : line.isEmpty
                                  ? kBodyStyle
                                  : kBodyStyle.copyWith(
                                      color: line.contains('PUC Paralela')
                                          ? kGold
                                          : kParchment,
                                      fontSize: 13,
                                      height: 1.35,
                                    ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'VOLTAR',
                  style: TextStyle(
                    color: kGold,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
