import 'package:examprep/Screens/home_screen.dart';
import 'package:examprep/Screens/registration_screen.dart';
import 'package:examprep/Services/auth/auth_service.dart';
import 'package:examprep/Theme/appTheme.dart';
import 'package:examprep/Widgets/auth_footer.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      resizeToAvoidBottomInset: false, // Prevents layout jumping when keyboard appears
      body: Stack(
        children: [
          // 🌿 TOP SAGE BLOB
          Positioned(
            top: -100,
            left: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primary.withOpacity(0.4),
                    AppTheme.primary.withOpacity(0.05),
                  ],
                ),
              ),
            ),
          ),

          // 🌸 BOTTOM LAVENDER BLOB
          Positioned(
            bottom: -120,
            right: -100,
            child: Transform.rotate(
              angle: 0.5,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.secondary.withOpacity(0.3),
                      AppTheme.secondary.withOpacity(0.05),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 🧾 CONTENT
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 170),

                  // HEADER
                  const Text(
                    "Welcome Back",
                    style: AppTheme.heading1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Sign in to access your inventory",
                    style: AppTheme.subtitle1.copyWith(color: AppTheme.textSecondary),
                  ),

                  const SizedBox(height: 60),

                  // INPUT FIELDS
                  TextFormField(
                    controller: emailController,
                    decoration: AppTheme.inputDecoration(
                      label: "EMAIL ADDRESS",
                      hint: "Enter your email",
                      icon: Icons.alternate_email_rounded,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: AppTheme.inputDecoration(
                      label: "PASSWORD",
                      hint: "Enter your password",
                      icon: Icons.lock_outline_rounded,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // LOGIN BUTTON (FIXED VISIBILITY)
                  AppTheme.gradientButton(
                    text: "LOGIN",
                    loading: _isLoading,
                    onPressed: () => _handleLogin(context),
                  ),

                  const Spacer(),

                  // FOOTER
                  Center(
                    child: AuthFooter(
                      text: "New here? ",
                      link: "Create Account",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterScreen()),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleLogin(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields"), backgroundColor: AppTheme.warning),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppTheme.error,
          ),
        );
      }
    }
  }
}