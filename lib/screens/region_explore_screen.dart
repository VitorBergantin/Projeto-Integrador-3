import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';
import '../models/game_region.dart';
import '../models/map_entity.dart';
import '../theme/game_theme.dart';
import '../widgets/dpad_widget.dart';
import '../widgets/action_buttons_widget.dart';
import 'game_screen.dart';

class RegionExploreScreen extends StatefulWidget {
  final int regionIndex;
  final String playerName;

  const RegionExploreScreen({
    super.key,
    required this.regionIndex,
    required this.playerName,
  });

  @override
  State<RegionExploreScreen> createState() => _RegionExploreScreenState();
}

class _RegionExploreScreenState extends State<RegionExploreScreen> {
  late int _px;
  late int _py;
  late List<MapEntity> _entities;
  MapEntity? _activeDialogue;
  int _dialogueLine = 0;

  @override
  void initState() {
    super.initState();
    _px = playerStartX(widget.regionIndex);
    _py = playerStartY(widget.regionIndex);
    _entities = entitiesForRegion(widget.regionIndex);
  }

  // ── Movimento ───────────────────────────────────────────────────
  void _move(int dx, int dy) {
    if (_activeDialogue != null) return;

    final nx = (_px + dx).clamp(0, kMapW - 1);
    final ny = (_py + dy).clamp(0, kMapH - 1);

    final entity = _entityAt(nx, ny);

    if (entity != null) {
      if (entity.type == EntityType.enemy ||
          entity.type == EntityType.boss) {
        _startCombat();
        return;
      }
      // NPC bloqueia o caminho — fica no lugar, abre diálogo
      _openDialogue(entity);
      return;
    }

    setState(() {
      _px = nx;
      _py = ny;
    });
  }

  // ── Ação (botão A) ───────────────────────────────────────────────
  void _onA() {
    if (_activeDialogue != null) {
      _advanceDialogue();
      return;
    }
    // Verifica NPC adjacente
    final adj = _adjacentNpc();
    if (adj != null) {
      _openDialogue(adj);
      return;
    }
    // Verifica inimigo adjacente
    final enemy = _adjacentEnemy();
    if (enemy != null) {
      _startCombat();
    }
  }

  void _onB() {
    if (_activeDialogue != null) {
      setState(() {
        _activeDialogue = null;
        _dialogueLine = 0;
      });
      return;
    }
    Navigator.pop(context);
  }

  void _openDialogue(MapEntity entity) {
    setState(() {
      _activeDialogue = entity;
      _dialogueLine = 0;
    });
  }

  void _advanceDialogue() {
    final d = _activeDialogue!;
    if (_dialogueLine < d.dialogues.length - 1) {
      setState(() => _dialogueLine++);
    } else {
      setState(() {
        _activeDialogue = null;
        _dialogueLine = 0;
      });
    }
  }

  void _startCombat() {
    final game = context.read<GameController>();
    game.enterRegion(widget.regionIndex);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameScreen(playerName: widget.playerName),
      ),
    );
  }

  // ── Helpers ─────────────────────────────────────────────────────
  MapEntity? _entityAt(int x, int y) {
    for (final e in _entities) {
      if (e.x == x && e.y == y) return e;
    }
    return null;
  }

  MapEntity? _adjacentNpc() {
    for (final e in _entities) {
      if (e.type != EntityType.npc) continue;
      if ((_px - e.x).abs() + (_py - e.y).abs() <= 1) return e;
    }
    return null;
  }

  MapEntity? _adjacentEnemy() {
    for (final e in _entities) {
      if (e.type != EntityType.enemy && e.type != EntityType.boss) continue;
      if ((_px - e.x).abs() + (_py - e.y).abs() <= 1) return e;
    }
    return null;
  }

  bool get _nearInteractable =>
      _adjacentNpc() != null || _adjacentEnemy() != null;

  @override
  Widget build(BuildContext context) {
    final region = gameRegions[widget.regionIndex];
    final nearNpc = _adjacentNpc();
    final nearEnemy = _adjacentEnemy();

    return Scaffold(
      backgroundColor: kNavy,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ─────────────────────────────────────────
            _ExploreTopBar(
              region: region,
              nearInteractable: _nearInteractable,
              nearNpcName: nearNpc?.name ?? nearEnemy?.name,
              onBack: () => Navigator.pop(context),
            ),

            // ── Map viewport ────────────────────────────────────
            Expanded(
              flex: 60,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: kNavy,
                  border: Border.all(color: kGold, width: 2.5),
                  borderRadius: BorderRadius.circular(4),
                ),
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  children: [
                    // Mapa
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _MapPainter(
                          px: _px,
                          py: _py,
                          entities: _entities,
                        ),
                      ),
                    ),

                    // Caixa de diálogo NPC (parte inferior do viewport)
                    if (_activeDialogue != null)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: _DialogueBox(
                          entity: _activeDialogue!,
                          line: _dialogueLine,
                          isLast: _dialogueLine ==
                              _activeDialogue!.dialogues.length - 1,
                        ),
                      ),

                    // Legenda de interação (pequena, no topo)
                    if (_nearInteractable && _activeDialogue == null)
                      Positioned(
                        top: 6,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: kNavy.withValues(alpha: 0.9),
                              border: Border.all(color: kGold),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              nearNpc != null
                                  ? '[ A ] Falar com ${nearNpc.name}'
                                  : '[ A ] Batalhar com ${nearEnemy!.name}',
                              style: const TextStyle(
                                  color: kGold, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // ── Brand label ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                '◆  EXPLORAÇÃO  ◆',
                style: TextStyle(
                  color: kGoldDark,
                  fontSize: 10,
                  letterSpacing: 4,
                ),
              ),
            ),

            // ── Controls ─────────────────────────────────────────
            Expanded(
              flex: 37,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DPadWidget(
                      onUp: () => _move(0, -1),
                      onDown: () => _move(0, 1),
                      onLeft: () => _move(-1, 0),
                      onRight: () => _move(1, 0),
                    ),
                    // Legenda
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _LegendDot(color: Colors.white, label: 'Você'),
                        const SizedBox(height: 6),
                        _LegendDot(
                            color: const Color(0xFF42A5F5),
                            label: 'NPC'),
                        const SizedBox(height: 6),
                        _LegendDot(
                            color: const Color(0xFFEF5350),
                            label: 'Inimigo'),
                        const SizedBox(height: 6),
                        _LegendDot(
                            color: const Color(0xFFFDD835),
                            label: 'Chefe'),
                      ],
                    ),
                    ActionButtonsWidget(
                      onA: _onA,
                      onB: _onB,
                      labelA: 'A',
                      labelB: 'B',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// TOP BAR
// ═══════════════════════════════════════════════════════════════
class _ExploreTopBar extends StatelessWidget {
  final GameRegion region;
  final bool nearInteractable;
  final String? nearNpcName;
  final VoidCallback onBack;

  const _ExploreTopBar({
    required this.region,
    required this.nearInteractable,
    required this.nearNpcName,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: kGoldDark, width: 1)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: ffBox(borderColor: kGoldDark, bgColor: kDarkBlue),
              child: const Row(
                children: [
                  Icon(Icons.map_outlined, color: kGoldDark, size: 13),
                  SizedBox(width: 4),
                  Text('Mapa',
                      style: TextStyle(color: kGoldDark, fontSize: 11)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(region.emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                region.name.toUpperCase(),
                style: const TextStyle(
                  color: kGold,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const Text('Exploração', style: kDimStyle),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// MAP PAINTER (CustomPainter)
// ═══════════════════════════════════════════════════════════════
class _MapPainter extends CustomPainter {
  final int px, py;
  final List<MapEntity> entities;

  const _MapPainter({
    required this.px,
    required this.py,
    required this.entities,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cW = size.width / kMapW;
    final cH = size.height / kMapH;

    // ── Fundo ────────────────────────────────────────────────
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFF080D1A),
    );

    // ── Grid sutil ───────────────────────────────────────────
    final gridPaint = Paint()
      ..color = const Color(0xFF1A2540)
      ..strokeWidth = 0.6;

    for (int x = 0; x <= kMapW; x++) {
      canvas.drawLine(
          Offset(x * cW, 0), Offset(x * cW, size.height), gridPaint);
    }
    for (int y = 0; y <= kMapH; y++) {
      canvas.drawLine(
          Offset(0, y * cH), Offset(size.width, y * cH), gridPaint);
    }

    // ── Entidades ─────────────────────────────────────────────
    for (final e in entities) {
      final cx = e.x * cW + cW / 2;
      final cy = e.y * cH + cH / 2;
      final r = min(cW, cH) * 0.36;

      // Sombra
      canvas.drawCircle(
        Offset(cx, cy + 1.5),
        r,
        Paint()..color = Colors.black45,
      );

      // Corpo
      canvas.drawCircle(
        Offset(cx, cy),
        r,
        Paint()..color = e.color,
      );

      // Borda
      canvas.drawCircle(
        Offset(cx, cy),
        r,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.25)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2,
      );

      // Chefe: círculo extra pulsante
      if (e.type == EntityType.boss) {
        canvas.drawCircle(
          Offset(cx, cy),
          r * 1.55,
          Paint()
            ..color = e.color.withValues(alpha: 0.25)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        );
      }
    }

    // ── Player (ponto branco) ─────────────────────────────────
    final pcx = px * cW + cW / 2;
    final pcy = py * cH + cH / 2;
    final pr = min(cW, cH) * 0.38;

    // Sombra
    canvas.drawCircle(
      Offset(pcx, pcy + 1.5),
      pr,
      Paint()..color = Colors.black45,
    );

    // Ponto branco
    canvas.drawCircle(
      Offset(pcx, pcy),
      pr,
      Paint()..color = Colors.white,
    );

    // Halo ao redor do player
    canvas.drawCircle(
      Offset(pcx, pcy),
      pr * 1.6,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.12)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(_MapPainter old) =>
      old.px != px || old.py != py;
}

// ═══════════════════════════════════════════════════════════════
// NPC DIALOGUE BOX (estilo Final Fantasy)
// ═══════════════════════════════════════════════════════════════
class _DialogueBox extends StatelessWidget {
  final MapEntity entity;
  final int line;
  final bool isLast;

  const _DialogueBox({
    required this.entity,
    required this.line,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kNavy,
        border: Border(top: BorderSide(color: kGold, width: 2)),
      ),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Speaker name box
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: ffBox(
              borderColor: entity.type == EntityType.npc
                  ? entity.color
                  : kCrimsonLight,
              bgColor: kDarkBlue,
            ),
            child: Text(
              entity.name.toUpperCase(),
              style: TextStyle(
                color: entity.type == EntityType.npc
                    ? entity.color
                    : kCrimsonLight,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 6),
          // Dialogue text
          Text(
            entity.dialogues.isNotEmpty
                ? entity.dialogues[line]
                : '',
            style: kBodyStyle,
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                isLast ? '[ B ] Fechar' : '[ A ] Continuar',
                style: TextStyle(
                  color: kGoldDark,
                  fontSize: 9,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(width: 6),
              const Text('▼',
                  style: TextStyle(color: kGold, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// LEGEND DOT
// ═══════════════════════════════════════════════════════════════
class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 5),
        Text(label,
            style: const TextStyle(color: kParchmentDim, fontSize: 9)),
      ],
    );
  }
}
