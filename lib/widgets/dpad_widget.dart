import 'package:flutter/material.dart';
import '../theme/game_theme.dart';

class DPadWidget extends StatelessWidget {
  final VoidCallback? onUp;
  final VoidCallback? onDown;
  final VoidCallback? onLeft;
  final VoidCallback? onRight;

  const DPadWidget({
    super.key,
    this.onUp,
    this.onDown,
    this.onLeft,
    this.onRight,
  });

  Widget _btn(IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: kGoldDark,
            width: 1.5,
          ),
          color: kDarkBlue,
        ),
        child: Icon(
          icon,
          color: kParchmentDim,
          size: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _btn(Icons.keyboard_arrow_up, onUp),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _btn(Icons.keyboard_arrow_left, onLeft),
            const SizedBox(width: 4),
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: kNavy,
                border: Border.all(color: kBorder, width: 1),
              ),
              child: const Center(
                child: Text('◆',
                    style: TextStyle(color: kBorder, fontSize: 10)),
              ),
            ),
            const SizedBox(width: 4),
            _btn(Icons.keyboard_arrow_right, onRight),
          ],
        ),
        const SizedBox(height: 4),
        _btn(Icons.keyboard_arrow_down, onDown),
      ],
    );
  }
}
