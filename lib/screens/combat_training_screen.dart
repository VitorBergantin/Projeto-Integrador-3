import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';
import '../models/game_region.dart';
import '../theme/game_theme.dart';
import 'game_screen.dart';

class CombatTrainingScreen extends StatelessWidget {
  final String playerName;
  const CombatTrainingScreen({super.key, required this.playerName});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameController>();
    final regions = gameRegions;

    return Scaffold(
      backgroundColor: kNavy,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: kGoldDark, width: 1)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: ffBox(
                        borderColor: kGoldDark,
                        bgColor: kDarkBlue,
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: kGoldDark,
                            size: 13,
                          ),
                          Text(
                            'Voltar',
                            style: TextStyle(color: kGoldDark, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('TREINO DE COMBATE', style: kTitleStyle),
                      Text(
                        'Sem geofencing  •  XP real',
                        style: TextStyle(color: kParchmentDim, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Info box ────────────────────────────────────
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              decoration: ffBox(
                borderColor: kGoldDark,
                bgColor: kGold.withValues(alpha: 0.06),
              ),
              child: Row(
                children: [
                  const Text('📖', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Pratique o combate sem precisar ir ao campus. '
                      'O XP ganho no treino conta para o seu personagem!',
                      style: TextStyle(
                        color: kParchmentDim,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Player stats mini ────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FfCornerBox(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    const Text('🧙', style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            game.player.name,
                            style: const TextStyle(
                              color: kGoldLight,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          FfBar(
                            label: 'HP',
                            current: game.player.hp,
                            max: game.player.maxHp,
                            color: kGreenHP,
                            lightColor: kGreenHPLight,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: ffBox(borderColor: kGold, bgColor: kNavy),
                      child: Column(
                        children: [
                          const Text(
                            'LV',
                            style: TextStyle(
                              color: kGoldDark,
                              fontSize: 8,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            '${game.player.level}',
                            style: const TextStyle(
                              color: kGold,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Label ───────────────────────────────────────
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('ESCOLHA A REGIÃO PARA TREINAR', style: kDimStyle),
            ),
            const SizedBox(height: 10),

            // ── Region list ─────────────────────────────────
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                itemCount: regions.length,
                itemBuilder: (context, index) {
                  final region = regions[index];
                  final difficulty = _difficulty(index);
                  return _TrainingRegionCard(
                    region: region,
                    index: index,
                    difficulty: difficulty,
                    onTap: () => _startTraining(context, game, index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startTraining(
    BuildContext context,
    GameController game,
    int regionIndex,
  ) {
    game.enterRegion(regionIndex);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => GameScreen(playerName: playerName)),
    );
  }

  String _difficulty(int index) {
    const levels = [
      'Iniciante',
      'Intermediário',
      'Avançado',
      'Expert',
      'Lendário',
    ];
    return levels[index];
  }
}

// ═══════════════════════════════════════════════════════════════
// REGION TRAINING CARD
// ═══════════════════════════════════════════════════════════════
class _TrainingRegionCard extends StatelessWidget {
  final GameRegion region;
  final int index;
  final String difficulty;
  final VoidCallback onTap;

  const _TrainingRegionCard({
    required this.region,
    required this.index,
    required this.difficulty,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: ffBox(
          borderColor: region.primaryColor.withValues(alpha: 0.6),
          bgColor: region.backgroundColor,
        ),
        child: Row(
          children: [
            // Emoji lateral colorido
            Container(
              width: 56,
              height: 72,
              decoration: BoxDecoration(
                color: region.primaryColor.withValues(alpha: 0.12),
                border: Border(
                  right: BorderSide(
                    color: region.primaryColor.withValues(alpha: 0.4),
                  ),
                ),
              ),
              child: Center(
                child: Text(region.emoji, style: const TextStyle(fontSize: 28)),
              ),
            ),

            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          region.name.toUpperCase(),
                          style: TextStyle(
                            color: region.primaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const Spacer(),
                        _DifficultyChip(
                          label: difficulty,
                          color: region.primaryColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${region.enemies.length} inimigos  •  até ${_maxXp(region)} XP',
                      style: const TextStyle(
                        color: kParchmentDim,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Inimigos em linha
                    Row(
                      children: region.enemies
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Image.asset(
                                e.assetPath,
                                width: 64,
                                height: 64,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),

            // Seta
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                Icons.play_arrow,
                color: region.primaryColor,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _maxXp(GameRegion region) =>
      region.enemies.fold(0, (sum, e) => sum + e.xpReward);
}

class _DifficultyChip extends StatelessWidget {
  final String label;
  final Color color;

  const _DifficultyChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        border: Border.all(color: color.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 9,
          letterSpacing: 1,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
