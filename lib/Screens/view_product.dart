import 'package:examprep/Screens/add_product.dart';
import 'package:examprep/Theme/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examprep/Services/DBOperation/crud_operation.dart';
import 'package:examprep/Screens/update_and_delete.dart'; 

class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key});
  final ProductDb db = ProductDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background, 
      appBar: AppBar(
        title: const Text(
          "Inventory",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: AppTheme.background, // Match background for a seamless look
        foregroundColor: AppTheme.textPrimary,
      ),
      
      // Floating Action Button with Sage-Lavender Gradient
      floatingActionButton: Container(
        height: 56,
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductScreen()));
          },
          label: const Text("Add Product", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5)),
          icon: const Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.transparent, // Important: let the container show the gradient
          elevation: 0,
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: db.getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppTheme.primary));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 100), // Bottom padding so FAB doesn't block items
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              var data = doc.data() as Map<String, dynamic>;
              
              return _buildProductCard(context, doc.id, data);
            },
          );
        },
      ),
    );
  }

  // Modern Card Design with Sage & Lavender Accents
  Widget _buildProductCard(BuildContext context, String docId, Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: AppTheme.cardDecoration(),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.primary.withOpacity(0.1), // Soft Sage wash
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.inventory_2_rounded, color: AppTheme.primary),
        ),
        title: Text(
          data['name'] ?? 'Unknown Product',
          style: AppTheme.subtitle1.copyWith(color: AppTheme.textPrimary),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.secondary.withOpacity(0.15), // Soft Lavender wash
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "\$${data['price']}",
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "ID: ${data['id'] ?? 'N/A'}",
                style: AppTheme.caption,
              ),
            ],
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded, color: AppTheme.textLight),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(docId: docId),
            ),
          );
        },
      ),
    );
  }

  // Placeholder for when the list is empty
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.accentLight,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.shopping_basket_outlined, size: 60, color: AppTheme.primary.withOpacity(0.5)),
          ),
          const SizedBox(height: 24),
          const Text(
            "Inventory is empty",
            style: AppTheme.heading5,
          ),
          const SizedBox(height: 8),
          const Text(
            "Your added products will appear here.",
            style: AppTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}