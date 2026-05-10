import 'package:flutter/material.dart';
import '../theme/game_theme.dart';

class ActionButtonsWidget extends StatelessWidget {
  final VoidCallback? onA;
  final VoidCallback? onB;
  final String labelA;
  final String labelB;

  const ActionButtonsWidget({
    super.key,
    this.onA,
    this.onB,
    this.labelA = 'A',
    this.labelB = 'B',
  });

  Widget _btn(String label, VoidCallback? onTap, {bool primary = false}) {
    final active = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: active
                ? (primary ? kGold : kGoldDark)
                : kBorder,
            width: active ? 2 : 1.5,
          ),
          color: active
              ? (primary
                  ? kGold.withValues(alpha: 0.15)
                  : kDarkBlue)
              : kNavy,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: active
                  ? (primary ? kGoldLight : kParchmentDim)
                  : kBorder,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _btn(labelA, onA, primary: true),
        const SizedBox(height: 8),
        _btn(labelB, onB),
      ],
    );
  }
}
