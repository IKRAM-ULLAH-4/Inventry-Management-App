import 'package:examprep/Theme/appTheme.dart';
import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  final String text;
  final String link;
  final VoidCallback onTap;

  const AuthFooter({
    super.key,
    required this.text,
    required this.link,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: const TextStyle(color: Colors.grey)),
        GestureDetector(
          onTap: onTap,
          child: Text(
            link,
            style: const TextStyle(
              color: AppTheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
