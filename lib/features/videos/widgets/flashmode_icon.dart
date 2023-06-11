import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashModeIcon extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final FlashMode flashMode;
  final Future<void> Function(FlashMode flashMode) setFlashMode;

  const FlashModeIcon({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.flashMode,
    required this.setFlashMode,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: isSelected ? Colors.yellow.shade300 : Colors.white,
      icon: Icon(icon),
      onPressed: () => setFlashMode(flashMode),
    );
  }
}
