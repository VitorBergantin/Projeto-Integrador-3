import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';
import '../theme/game_theme.dart';

class HeroScreen extends StatelessWidget {
  const HeroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameController>();
    final player = game.player;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text('HERÓI', style: kTitleStyle),
            const Divider(color: kGoldDark, height: 20),

            // ── Avatar + stats ─────────────────────────────────
            FfCornerBox(
              child: Row(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: ffBox(borderColor: kGoldDark, bgColor: kNavy),
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
                          player.name.toUpperCase(),
                          style: const TextStyle(
                            color: kGoldLight,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _classeDoNivel(player.level),
                          style: const TextStyle(
                              color: kParchmentDim, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'NÍVEL  ${player.level}',
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

            // ── Barras HP / XP ─────────────────────────────────
            FfCornerBox(
              child: Column(
                children: [
                  FfBar(
                    label: 'HP',
                    current: player.hp,
                    max: player.maxHp,
                    color: kGreenHP,
                    lightColor: kGreenHPLight,
                  ),
                  const SizedBox(height: 10),
                  FfBar(
                    label: 'XP',
                    current: player.xp,
                    max: player.xpToNextLevel,
                    color: kBlueXP,
                    lightColor: kBlueXPLight,
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${player.xpToNextLevel - player.xp} XP para próximo nível',
                      style: const TextStyle(
                          color: kParchmentDim, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Atributos ──────────────────────────────────────
            const Text('ATRIBUTOS', style: kDimStyle),
            const SizedBox(height: 8),
            FfCornerBox(
              child: Column(
                children: [
                  _AtribRow('⚔️', 'Ataque',
                      '${10 + player.level * 3}'),
                  const Divider(color: kBorder, height: 16),
                  _AtribRow('🛡️', 'Defesa',
                      '${5 + player.level * 2}'),
                  const Divider(color: kBorder, height: 16),
                  _AtribRow('🧠', 'Sabedoria',
                      '${player.level * 5}'),
                  const Divider(color: kBorder, height: 16),
                  _AtribRow('✨', 'Magia',
                      '${8 + player.level * 4}'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Região atual ───────────────────────────────────
            const Text('REGIÃO ATUAL', style: kDimStyle),
            const SizedBox(height: 8),
            FfCornerBox(
              child: Row(
                children: [
                  Text(
                    game.currentRegion.emoji,
                    style: const TextStyle(fontSize: 32),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        game.currentRegion.name.toUpperCase(),
                        style: const TextStyle(
                          color: kGold,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        'Região ${player.currentRegion + 1} de 5',
                        style: const TextStyle(
                            color: kParchmentDim, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Conquistas rápidas ────────────────────────────
            const Text('CONQUISTAS', style: kDimStyle),
            const SizedBox(height: 8),
            Row(
              children: [
                _Badge('🐛', 'Caçador\nde Bugs', player.level >= 2),
                const SizedBox(width: 8),
                _Badge('🌀', 'Mestre da\nRecursão', player.level >= 5),
                const SizedBox(width: 8),
                _Badge('🧠', 'Sábio\nDigital', player.level >= 8),
                const SizedBox(width: 8),
                _Badge('👁️', 'Guardião\nVencido', player.currentRegion >= 4),
              ],
            ),
          ],
        ),
      ),
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
            child: Text(label,
                style:
                    const TextStyle(color: kParchment, fontSize: 13))),
        Text(value,
            style: const TextStyle(
                color: kGoldLight,
                fontWeight: FontWeight.bold,
                fontSize: 14)),
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
          bgColor: unlocked
              ? kGold.withValues(alpha: 0.08)
              : kNavy,
        ),
        child: Column(
          children: [
            Text(
              emoji,
              style: TextStyle(
                  fontSize: 22,
                  color: unlocked ? null : const Color(0x44FFFFFF)),
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
