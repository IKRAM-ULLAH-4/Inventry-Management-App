import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examprep/Theme/appTheme.dart';
import 'package:examprep/Widgets/app_drawer.dart';
import 'package:examprep/Screens/add_product.dart';
import 'package:examprep/Screens/view_product.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      drawer: const AppDrawer(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. PREMIUM COLLAPSIBLE HEADER
          _buildSliverAppBar(context),

          // 2. DASHBOARD CONTENT
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Inventory Summary",
                    style: AppTheme.heading5,
                  ),
                  const SizedBox(height: 16),
                  
                  // REAL-TIME STATS ROW
                  _buildQuickStats(),
                  
                  const SizedBox(height: 35),
                  
                  const Text(
                    "Quick Management",
                    style: AppTheme.heading5,
                  ),
                  const SizedBox(height: 16),
                  
                  // UNIQUE ACTION TILES
                  _buildActionGrid(context),
                  
                  const SizedBox(height: 30),
                  
                  // UNIQUE "RECENT ACTIVITY" PLACEHOLDER FOR UX DEPTH
                  _buildRecentActivityHint(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= SLIVER HEADER =================
  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      stretch: true,
      backgroundColor: AppTheme.primary,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu_rounded, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.primaryGradient,
          ),
          child: Stack(
            children: [
              // Abstract Background Decor
              Positioned(
                right: -30,
                top: -20,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white.withOpacity(0.05),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, bottom: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome back,",
                      style: AppTheme.bodyText2.copyWith(color: Colors.white.withOpacity(0.8)),
                    ),
                    const Text(
                      "Inventory Admin",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= REAL-TIME STATS =================
  Widget _buildQuickStats() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        final count = snapshot.hasData ? snapshot.data!.docs.length.toString() : "...";
        
        return Row(
          children: [
            _statCard(
              "Total Items",
              count,
              Icons.inventory_2_rounded,
              AppTheme.primary,
            ),
            const SizedBox(width: 16),
            // Unique UX: Secondary Stat (e.g., placeholder for categories or low stock)
            _statCard(
              "Stock Value",
              "Active", 
              Icons.auto_graph_rounded,
              AppTheme.secondary,
            ),
          ],
        );
      },
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: AppTheme.cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 16),
            Text(value, style: AppTheme.heading4),
            const SizedBox(height: 4),
            Text(title, style: AppTheme.caption),
          ],
        ),
      ),
    );
  }

  // ================= ACTION TILES =================
  Widget _buildActionGrid(BuildContext context) {
    return Column(
      children: [
        _wideActionCard(
          context,
          "View Full Inventory",
          "Manage and edit your products",
          Icons.format_list_bulleted_rounded,
          AppTheme.primary,
          () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductListScreen())),
        ),
        const SizedBox(height: 16),
        _wideActionCard(
          context,
          "Register New Product",
          "Add new items to the catalog",
          Icons.add_circle_outline_rounded,
          AppTheme.secondary,
          () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddProductScreen())),
        ),
      ],
    );
  }

  Widget _wideActionCard(BuildContext context, String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.inputBorderColor.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTheme.subtitle1.copyWith(color: AppTheme.textPrimary)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTheme.caption),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppTheme.textLight),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivityHint() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.accentLight.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primary.withOpacity(0.1), width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified_user_outlined, color: AppTheme.primary, size: 20),
          const SizedBox(width: 12),
          Text(
            "System is synced with Cloud Firestore",
            style: AppTheme.caption.copyWith(color: AppTheme.primary, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}