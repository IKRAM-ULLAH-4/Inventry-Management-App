import 'package:examprep/Theme/appTheme.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool obscure;

  const InputField({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: AppTheme.inputDecoration(
        label: label,
        icon: icon,
        fillColor: AppTheme.surface,
      ),
    );
}
}