import 'package:flutter/material.dart';

/// Minimal reusable button. Exists so `test/widgets/primary_button_test.dart`
/// has a real widget to snapshot — demonstrates the golden-test flow.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.enabled = true,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: enabled ? onPressed : null,
      child: Text(label),
    );
  }
}
