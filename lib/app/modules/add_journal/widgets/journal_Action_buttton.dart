import 'package:flutter/material.dart';
import '../../../shared/theme/app_typography.dart';

class JournalActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const JournalActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: Colors.amber[600]!, width: 1.5),
        minimumSize: const Size(double.infinity, 48),
      ),
      icon: Icon(icon, color: Colors.amber[600], size: 20),
      label: Text(
        label,
        style: AppTypography.sMedium.copyWith(
          color: Colors.amber[600],
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
