import 'package:flutter/material.dart';
import '../theme/game_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HeroScreen extends StatelessWidget {
  const HeroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('jogadores').doc(uid).get(),

      builder: (context, snapshot) {
        // ─────────────────────────────
        // Loading
        // ─────────────────────────────
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.data!.data() as Map<String, dynamic>;
        // Jogador
        final nome = data['nome'] ?? 'Jogador';
        final xp = data['xp'] ?? 0;
        final level = data['level'] ?? 1;
        final progresso = data['progresso'] as Map<String, dynamic>;
        // Regiões completas
        int regioesConcluidas = 0;

        if ((progresso['h15'] ?? 0) >= 5) {
          regioesConcluidas++;
        }
        if ((progresso['biblioteca'] ?? 0) >= 5) {
          regioesConcluidas++;
        }
        if ((progresso['refeitorio'] ?? 0) >= 5) {
          regioesConcluidas++;
        }
        if ((progresso['manacas'] ?? 0) >= 5) {
          regioesConcluidas++;
        }
        if ((progresso['capela'] ?? 0) >= 1) {
          regioesConcluidas++;
        }
        // XP necessário
        final xpNext = level * 100;
        // HP
        final hp = 100 + (level * 20);
        final maxHp = 100 + (level * 20);

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text('HERÓI', style: kTitleStyle),
                const Divider(color: kGoldDark, height: 20),
                // Avatar
                FfCornerBox(
                  child: Row(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: ffBox(
                          borderColor: kGoldDark,
                          bgColor: kNavy,
                        ),
                        child: const Center(
                          child: Text('🧙', style: TextStyle(fontSize: 40)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nome.toUpperCase(),
                              style: const TextStyle(
                                color: kGoldLight,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _classeDoNivel(level),
                              style: const TextStyle(
                                color: kParchmentDim,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'NÍVEL  $level',
                              style: const TextStyle(
                                color: kGold,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Barras
                FfCornerBox(
                  child: Column(
                    children: [
                      FfBar(
                        label: 'HP',
                        current: hp,
                        max: maxHp,
                        color: kGreenHP,
                        lightColor: kGreenHPLight,
                      ),

                      const SizedBox(height: 10),
                      FfBar(
                        label: 'XP',
                        current: xp,
                        max: xpNext,
                        color: kBlueXP,
                        lightColor: kBlueXPLight,
                      ),

                      const SizedBox(height: 6),

                      Align(
                        alignment: Alignment.centerRight,

                        child: Text(
                          '${xpNext - xp} XP para próximo nível',

                          style: const TextStyle(
                            color: kParchmentDim,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Região atual
                const Text('PROGRESSO', style: kDimStyle),
                const SizedBox(height: 8),
                FfCornerBox(
                  child: Column(
                    children: [
                      _AtribRow(
                        '🏆',
                        'Regiões concluídas',
                        '$regioesConcluidas/5',
                      ),
                      const Divider(color: kBorder, height: 16),
                      _AtribRow('⚡', 'XP Total', '$xp'),
                      const Divider(color: kBorder, height: 16),
                      _AtribRow('⭐', 'Nível', '$level'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _classeDoNivel(int level) {
    if (level < 3) return 'Aprendiz da PUC';
    if (level < 6) return 'Estudante Corajoso';
    if (level < 9) return 'Veterano do Campus';
    return 'Mestre das Ciências';
  }
}

class _AtribRow extends StatelessWidget {
  final String emoji;
  final String label;
  final String value;

  const _AtribRow(this.emoji, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: kParchment, fontSize: 13),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: kGoldLight,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final String emoji;
  final String label;
  final bool unlocked;

  const _Badge(this.emoji, this.label, this.unlocked);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: ffBox(
          borderColor: unlocked ? kGold : kBorder,
          bgColor: unlocked ? kGold.withValues(alpha: 0.08) : kNavy,
        ),
        child: Column(
          children: [
            Text(
              emoji,
              style: TextStyle(
                fontSize: 22,
                color: unlocked ? null : const Color(0x44FFFFFF),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: unlocked ? kParchmentDim : kBorder,
                fontSize: 9,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
