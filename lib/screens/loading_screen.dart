import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/audio_controller.dart';
import '../theme/game_theme.dart';
import 'home_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _fadeCtrl;
  late final AnimationController _pulseCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _pulseAnim;

  int _dotCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<AudioController>().playLogin();
    });

    // Fade in da logo
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);
    _fadeCtrl.forward();

    // Pulso sutil na logo
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    // Animação dos pontinhos de carregamento
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return false;
      setState(() => _dotCount = (_dotCount + 1) % 4);
      return true;
    });

    // Navega para HomeScreen após 3 segundos
    Future.delayed(const Duration(milliseconds: 3200), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, _, _) => const HomeScreen(),
          transitionDuration: const Duration(milliseconds: 800),
          transitionsBuilder: (_, anim, _, child) =>
              FadeTransition(opacity: anim, child: child),
        ),
      );
    });
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dots = '.' * _dotCount;

    return Scaffold(
      backgroundColor: kNavy,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: Stack(
          children: [
            // ── Fundo decorativo (linhas diagonais sutis) ──────
            Positioned.fill(child: CustomPaint(painter: _GridPainter())),

            // ── Conteúdo central ───────────────────────────────
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo com pulso
                  ScaleTransition(
                    scale: _pulseAnim,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        border: Border.all(color: kGold, width: 2.5),
                        borderRadius: BorderRadius.circular(16),
                        color: kDarkBlue,
                        boxShadow: [
                          BoxShadow(
                            color: kGold.withValues(alpha: 0.25),
                            blurRadius: 30,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image.asset(
                          'assets/images/logo.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const Center(
                            child: Text('⚔️', style: TextStyle(fontSize: 72)),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Título
                  const Text(
                    'INVASÃO DA PUC',
                    style: TextStyle(
                      color: kGold,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'RPG  •  QUIZ  •  AVENTURA',
                    style: TextStyle(
                      color: kParchmentDim,
                      fontSize: 11,
                      letterSpacing: 3,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Barra de carregamento estilo FF
                  _FfLoadingBar(),

                  const SizedBox(height: 14),

                  // Texto "Carregando..."
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Carregando',
                        style: TextStyle(
                          color: kParchmentDim,
                          fontSize: 11,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(
                        width: 24,
                        child: Text(
                          dots,
                          style: const TextStyle(
                            color: kGold,
                            fontSize: 11,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Rodapé ────────────────────────────────────────
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'PROJETO INTEGRADOR 3  •  PUC CAMPINAS',
                  style: TextStyle(
                    color: kBorder,
                    fontSize: 9,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Barra de carregamento animada ──────────────────────────────────
class _FfLoadingBar extends StatefulWidget {
  @override
  State<_FfLoadingBar> createState() => _FfLoadingBarState();
}

class _FfLoadingBarState extends State<_FfLoadingBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..forward();
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, _) {
        return Container(
          width: 220,
          height: 12,
          decoration: BoxDecoration(
            border: Border.all(color: kGoldDark, width: 1.5),
            borderRadius: BorderRadius.circular(2),
            color: kDarkBlue,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _anim.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                gradient: LinearGradient(
                  colors: [kGoldDark, kGold, kGoldLight],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Fundo com grade decorativa ─────────────────────────────────────
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kGoldDark.withValues(alpha: 0.06)
      ..strokeWidth = 1;

    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
