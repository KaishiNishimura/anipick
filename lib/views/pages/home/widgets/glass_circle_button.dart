part of '../discover_page.dart';

final class _GlassCircleButton extends StatelessWidget {
  const _GlassCircleButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(500),
      child: AdaptiveButton.child(
        onPressed: onPressed,
        color: AppColors.accent_300,
        child: SizedBox(
          width: 50,
          height: 50,
          child: Icon(icon, color: AppColors.accent_700),
        ),
      ),
    );
  }
}
