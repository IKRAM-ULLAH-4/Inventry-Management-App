import 'package:examprep/Theme/appTheme.dart';
import 'package:examprep/Widgets/auth_footer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      // Prevents the keyboard from breaking the background decoration
      resizeToAvoidBottomInset: false, 
      body: Stack(
        children: [
          // 🌿 TOP SAGE BLOB
          Positioned(
            top: -100,
            left: -80,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primary.withOpacity(0.35),
                    AppTheme.primary.withOpacity(0.05),
                  ],
                ),
              ),
            ),
          ),

          // 🌸 BOTTOM LAVENDER BLOB
          Positioned(
            bottom: -100,
            right: -80,
            child: Transform.rotate(
              angle: -0.2,
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.secondary.withOpacity(0.25),
                      AppTheme.secondary.withOpacity(0.05),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Back button
          Positioned(
            top: 50,
            left: 15,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: AppTheme.textPrimary, size: 22),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 120), 
                  const Text(
                    "Create Account",
                    style: AppTheme.heading1,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Join us to start managing your inventory",
                    style: AppTheme.subtitle1,
                  ),

                  const SizedBox(height: 40),

                  // Form fields using high-end AppTheme decoration
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            decoration: AppTheme.inputDecoration(
                              label: "FULL NAME",
                              hint: "Enter your name",
                              icon: Icons.person_outline_rounded,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: emailController,
                            decoration: AppTheme.inputDecoration(
                              label: "EMAIL ADDRESS",
                              hint: "Enter your email",
                              icon: Icons.alternate_email_rounded,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: AppTheme.inputDecoration(
                              label: "PASSWORD",
                              hint: "Create a password",
                              icon: Icons.lock_outline_rounded,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: confirmController,
                            obscureText: true,
                            decoration: AppTheme.inputDecoration(
                              label: "CONFIRM PASSWORD",
                              hint: "Repeat password",
                              icon: Icons.lock_reset_rounded,
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Premium Gradient Sign Up Button
                          AppTheme.gradientButton(
                            text: "SIGN UP",
                            loading: _isLoading,
                            onPressed: () => _handleSignUp(context),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),

                  // Footer at the very bottom
                  Center(
                    child: AuthFooter(
                      text: "Already have an account? ",
                      link: "Sign in",
                      onTap: () => Navigator.pop(context),
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

  void _handleSignUp(BuildContext context) async {
    if (passwordController.text != confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match"),
          backgroundColor: AppTheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (context.mounted) Navigator.pop(context);
    } catch (e) {
      setState(() => _isLoading = false);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppTheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}