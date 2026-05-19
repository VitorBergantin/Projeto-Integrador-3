import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';
import '../models/game_region.dart';
import '../theme/game_theme.dart';
import 'region_explore_screen.dart';

class MissionsScreen extends StatelessWidget {
  const MissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameController>();
    final regions = gameRegions;
    final currentRegion = game.player.currentRegion;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('MISSÕES', style: kTitleStyle),
                const Divider(color: kGoldDark, height: 20),
                Text(
                  'Explore o campus da PUC e derrote os inimigos de cada região.',
                  style: kBodyStyle.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  'Regiões desbloqueadas: ${currentRegion + 1}/5',
                  style: const TextStyle(color: kGold, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ── Region list ────────────────────────────────────
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              itemCount: regions.length,
              itemBuilder: (context, index) {
                final region = regions[index];
                final isUnlocked = index <= currentRegion;
                final isCurrent = index == currentRegion;
                final isCompleted = index < currentRegion;

                return _RegionCard(
                  region: region,
                  index: index,
                  isUnlocked: isUnlocked,
                  isCurrent: isCurrent,
                  isCompleted: isCompleted,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RegionCard extends StatelessWidget {
  final GameRegion region;
  final int index;
  final bool isUnlocked;
  final bool isCurrent;
  final bool isCompleted;

  const _RegionCard({
    required this.region,
    required this.index,
    required this.isUnlocked,
    required this.isCurrent,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isCompleted
        ? kGoldDark
        : isCurrent
            ? region.primaryColor
            : kBorder;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: ffBox(
        borderColor: borderColor,
        bgColor: isUnlocked ? kDarkBlue : kNavy,
      ),
      child: Column(
        children: [
          // ── Header ──────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: borderColor.withValues(alpha: 0.4))),
            ),
            child: Row(
              children: [
                Text(
                  region.emoji,
                  style: TextStyle(
                    fontSize: 28,
                    color: isUnlocked ? null : const Color(0x44FFFFFF),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            region.name.toUpperCase(),
                            style: TextStyle(
                              color: isUnlocked ? kGold : kBorder,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (isCompleted)
                            const Text('✓',
                                style: TextStyle(
                                    color: kGreenHPLight, fontSize: 13)),
                          if (isCurrent)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: region.primaryColor
                                    .withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(
                                    color: region.primaryColor, width: 1),
                              ),
                              child: Text(
                                'ATUAL',
                                style: TextStyle(
                                    color: region.primaryColor,
                                    fontSize: 8,
                                    letterSpacing: 1),
                              ),
                            ),
                          if (!isUnlocked)
                            const Text('🔒',
                                style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Text(
                        'Região ${index + 1} de 5',
                        style: const TextStyle(
                            color: kParchmentDim, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Body ─────────────────────────────────────────
          if (isUnlocked)
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    region.description,
                    style: const TextStyle(
                        color: kParchmentDim, fontSize: 12, height: 1.5),
                  ),
                  const SizedBox(height: 10),
                  const Text('INIMIGOS:', style: kDimStyle),
                  const SizedBox(height: 6),
                  ...region.enemies.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          Text(e.emoji,
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              e.name,
                              style: const TextStyle(
                                  color: kParchment, fontSize: 12),
                            ),
                          ),
                          Text(
                            'HP ${e.maxHp}  •  +${e.xpReward} XP',
                            style: const TextStyle(
                                color: kGoldDark, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('📍', style: TextStyle(fontSize: 14)),
                      const SizedBox(width: 6),
                      Text(
                        'Vá fisicamente até ${region.name} na PUC',
                        style: const TextStyle(
                            color: kParchmentDim, fontSize: 11),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ── Botão Explorar ─────────────────────────
                  GestureDetector(
                    onTap: () {
                      final game = context
                          .read<GameController>();
                      game.enterRegion(index);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegionExploreScreen(
                            regionIndex: index,
                            playerName: game.player.name,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10),
                      decoration: ffBox(
                        borderColor: region.primaryColor
                            .withValues(alpha: 0.7),
                        bgColor: region.primaryColor
                            .withValues(alpha: 0.08),
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          const Text('🗺️',
                              style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 8),
                          Text(
                            'EXPLORAR REGIÃO',
                            style: TextStyle(
                              color: region.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.all(14),
              child: Row(
                children: [
                  Text('🔒', style: TextStyle(fontSize: 18)),
                  SizedBox(width: 10),
                  Text(
                    'Complete as regiões anteriores\npara desbloquear.',
                    style: TextStyle(color: kBorder, fontSize: 12, height: 1.5),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
