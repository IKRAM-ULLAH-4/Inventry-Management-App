import 'package:flutter/material.dart';

class AppTheme {
  /* -------------------------------------------------------------------------- */
  /* CORE COLORS                                                                */
  /* -------------------------------------------------------------------------- */

  // Muted Sage (Primary) - Professional & Organic
  static const Color primary = Color(0xFF7F8260); 
  // Dusty Lavender (Secondary) - High Contrast for UI depth
  static const Color secondary = Color(0xFFBBA1C9); 

  // Accents for subtle UI elements
  static const Color accent = Color(0xFF9EA085); 
  static const Color accentLight = Color(0xFFF2F3EF); 

  /* -------------------------------------------------------------------------- */
  /* BACKGROUNDS                                                                */
  /* -------------------------------------------------------------------------- */

  // Using "Alabaster" instead of pure white reduces eye fatigue (Best UX)
  static const Color background = Color(0xFFFAF9F6); 
  static const Color lightBackground = Color(0xFFF3F4F1); 
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);

  static const Color inputFillColor = Color(0xFFFFFFFF); 
  static const Color inputBorderColor = Color(0xFFE5E7E1); 

  /* -------------------------------------------------------------------------- */
  /* TEXT                                                                       */
  /* -------------------------------------------------------------------------- */

  // Deep Olive-Slate for maximum readability without harshness
  static const Color textPrimary = Color(0xFF2C2E26); 
  static const Color textSecondary = Color(0xFF5B5E50); 
  static const Color textLight = Color(0xFF9EA091); 
  static const Color textOnPrimary = Colors.white;

  /* -------------------------------------------------------------------------- */
  /* STATUS                                                                     */
  /* -------------------------------------------------------------------------- */

  static const Color success = Color(0xFF8DA399); 
  static const Color error = Color(0xFFC9A1A1);   
  static const Color warning = Color(0xFFD9C5B2);
  static const Color info = Color(0xFFBBA1C9);

  /* -------------------------------------------------------------------------- */
  /* SHADOW                                                                     */
  /* -------------------------------------------------------------------------- */

  // Tinted shadow creates a "Natural" elevation effect
  static const Color shadowColor = Color(0x123A3D30); 

  /* -------------------------------------------------------------------------- */
  /* GRADIENTS                                                                  */
  /* -------------------------------------------------------------------------- */

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF7F8260),
      Color(0xFFBBA1C9),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient softBackgroundGradient = LinearGradient(
    colors: [Color(0xFFFAF9F6), Color(0xFFF3F4F1)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /* -------------------------------------------------------------------------- */
  /* TYPOGRAPHY                                                                 */
  /* -------------------------------------------------------------------------- */

  static const TextStyle heading1 = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.8,
    color: textPrimary,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: textPrimary,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: textPrimary,
  );

  static const TextStyle heading4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: textPrimary,
  );

  static const TextStyle heading5 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textSecondary,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textSecondary,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16,
    height: 1.5,
    color: textPrimary,
  );

  static const TextStyle bodyText2 = TextStyle(
    fontSize: 14,
    height: 1.5,
    color: textSecondary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: textLight,
    letterSpacing: 0.2,
  );

  static const TextStyle inputLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w800,
    color: textSecondary,
    letterSpacing: 1.2,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.0,
    color: textOnPrimary,
  );

  /* -------------------------------------------------------------------------- */
  /* INPUT DECORATION                                                           */
  /* -------------------------------------------------------------------------- */

  static InputDecoration inputDecoration({
    String? label,
    String? hint,
    IconData? icon,
    Color? fillColor,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      hintStyle: const TextStyle(color: textLight, fontSize: 14),
      labelStyle: inputLabel,
      prefixIcon: icon != null
          ? Icon(icon, size: 20, color: primary.withOpacity(0.8))
          : null,
      filled: true,
      fillColor: fillColor ?? inputFillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      // Rounded 12px is the industry standard for "High-End" mobile UX
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: inputBorderColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: inputBorderColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: secondary, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: error, width: 1.5),
      ),
    );
  }

  /* -------------------------------------------------------------------------- */
  /* CARD STYLE                                                                 */
  /* -------------------------------------------------------------------------- */

  static BoxDecoration cardDecoration({Color? color}) {
    return BoxDecoration(
      color: color ?? cardBackground,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: shadowColor,
          blurRadius: 30,
          offset: Offset(0, 12),
        ),
      ],
    );
  }

  /* -------------------------------------------------------------------------- */
  /* BUTTON STYLES                                                              */
  /* -------------------------------------------------------------------------- */

  static ButtonStyle primaryButton() {
    return ElevatedButton.styleFrom(
      backgroundColor: primary,
      foregroundColor: textOnPrimary,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.symmetric(vertical: 18),
    );
  }

  static ButtonStyle gradientButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: textOnPrimary,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    );
  }

  static ButtonStyle dangerButton() {
    return ElevatedButton.styleFrom(
      backgroundColor: error,
      foregroundColor: textOnPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    );
  }

  /* -------------------------------------------------------------------------- */
  /* GRADIENT BUTTON WIDGET                                                     */
  /* -------------------------------------------------------------------------- */

  static Widget gradientButton({
    required String text,
    required VoidCallback onPressed,
    bool loading = false,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: primaryGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: loading ? null : onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 60,
            alignment: Alignment.center,
            child: loading
                ? const SizedBox(
                    height: 24, width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                  )
                : Text(text, style: button),
          ),
        ),
      ),
    );
  }

  /* -------------------------------------------------------------------------- */
  /* THEME DATA                                                                 */
  /* -------------------------------------------------------------------------- */

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: background,
    fontFamily: 'Inter',
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: secondary,
      error: error,
      surface: surface,
      onPrimary: textOnPrimary,
      onSecondary: textOnPrimary,
      onSurface: textPrimary,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: background,
      foregroundColor: textPrimary,
      centerTitle: false,
      titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: textPrimary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: primaryButton()),
  );
}