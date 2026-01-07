import 'package:examprep/Services/DBOperation/crud_operation.dart';
import 'package:examprep/Theme/appTheme.dart';
import 'package:examprep/model/product.model.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final String docId;
  const ProductDetailScreen({super.key, required this.docId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDb db = ProductDb();
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final price = TextEditingController();
  final desc = TextEditingController();

  bool loading = true;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    try {
      final snap = await db.getProduct(widget.docId);
      final data = snap.data() as Map<String, dynamic>;
      setState(() {
        name.text = data['name'] ?? '';
        price.text = data['price']?.toString() ?? '0';
        desc.text = data['description'] ?? '';
        loading = false;
      });
    } catch (e) {
      debugPrint("Error loading product: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: loading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.primary))
          : GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  _buildSliverAppBar(),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
                      child: _buildFormCard(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      stretch: true,
      backgroundColor: AppTheme.primary,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_sweep_rounded, color: Colors.white),
          onPressed: () => _showDeleteBottomSheet(context),
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          "Product Details",
          style: AppTheme.heading5.copyWith(color: Colors.white, fontSize: 18),
        ),
        background: Container(
          decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
          child: Center(
            child: Opacity(
              opacity: 0.15,
              child: Icon(Icons.inventory_2_rounded, size: 140, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      decoration: AppTheme.cardDecoration(),
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Edit Information", style: AppTheme.heading4),
            const SizedBox(height: 32),
            _field("PRODUCT NAME", name, Icons.shopping_bag_outlined),
            const SizedBox(height: 24),
            _field("PRICE (USD)", price, Icons.payments_outlined,
                keyboard: const TextInputType.numberWithOptions(decimal: true)),
            const SizedBox(height: 24),
            _field("DESCRIPTION", desc, Icons.description_outlined, lines: 4),
            const SizedBox(height: 40),
            AppTheme.gradientButton(
              text: "UPDATE PRODUCT",
              loading: _isUpdating,
              onPressed: _handleUpdate,
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController controller, IconData icon,
      {TextInputType keyboard = TextInputType.text, int lines = 1}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      maxLines: lines,
      style: AppTheme.bodyText1,
      decoration: AppTheme.inputDecoration(label: label, icon: icon),
      validator: (v) => v!.isEmpty ? "Required" : null,
    );
  }

  // ================= DESTRUCTIVE OPERATION: MODAL BOTTOM SHEET =================
  void _showDeleteBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle for sliding
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.delete_forever_rounded, color: AppTheme.error, size: 40),
            ),
            const SizedBox(height: 24),
            const Text("Delete Product?", style: AppTheme.heading4),
            const SizedBox(height: 12),
            const Text(
              "Are you sure you want to remove this item? This action is permanent and cannot be reversed.",
              textAlign: TextAlign.center,
              style: AppTheme.bodyText2,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.grey[300]!),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text("CANCEL", style: AppTheme.subtitle2.copyWith(color: AppTheme.textSecondary)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      db.deleteProduct(widget.docId);
                      Navigator.pop(context); // Close sheet
                      Navigator.pop(context); // Go back to list
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.error,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text("DELETE", style: AppTheme.button),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleUpdate() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isUpdating = true);
    try {
      db.updateProduct(Product(
        id: widget.docId,
        name: name.text.trim(),
        price: double.parse(price.text.trim()),
        description: desc.text.trim(),
      ));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Product synchronized successfully"),
          backgroundColor: AppTheme.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      setState(() => _isUpdating = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sync Error: $e"), backgroundColor: AppTheme.error),
      );
    }
  }
}