import 'package:examprep/Theme/appTheme.dart';
import 'package:flutter/material.dart';


class GradientBlob extends StatelessWidget {
  const GradientBlob({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primary, AppTheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(120),
      ),
    );
  }
}
