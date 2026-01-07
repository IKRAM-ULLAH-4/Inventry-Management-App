import 'package:examprep/Screens/add_product.dart';
import 'package:examprep/Screens/login_screen.dart';
import 'package:examprep/Screens/view_product.dart'; 
import 'package:examprep/Theme/appTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      backgroundColor: AppTheme.background, 
      child: Column(
        children: [
          _buildHeader(user),
          const SizedBox(height: 12),
          // Scrollable Menu
          Expanded(child: _buildMenu(context)),
          // Sticky Logout at bottom
          _buildFooter(context),
        ],
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader(User? user) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 64, 24, 32),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: AppTheme.surface,
            child: Icon(Icons.person_rounded, size: 36, color: AppTheme.primary),
          ),
          const SizedBox(height: 18),
          Text(
            user?.displayName ?? "Admin User",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 20,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user?.email ?? "admin@inventory.com",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // ================= MENU =================
  Widget _buildMenu(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        _drawerItem(
          icon: Icons.inventory_2_rounded,
          title: "Product List",
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => ProductListScreen()));
          },
        ),
        _drawerItem(
          icon: Icons.add_box_rounded,
          title: "Add New Product",
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AddProductScreen()));
          },
        ),
      ],
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        splashColor: AppTheme.secondary.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppTheme.primary, size: 22),
        ),
        title: Text(
          title,
          style: AppTheme.subtitle1.copyWith(
            fontSize: 15,
            color: AppTheme.textPrimary,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppTheme.textLight),
      ),
    );
  }

  // ================= FOOTER =================
  Widget _buildFooter(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: InkWell(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: AppTheme.error.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout_rounded, color: AppTheme.error, size: 20),
                SizedBox(width: 10),
                Text(
                  "Logout",
                  style: TextStyle(
                    color: AppTheme.error,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}