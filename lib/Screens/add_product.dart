import 'package:flutter/material.dart';
import 'package:examprep/Theme/appTheme.dart';
import 'package:examprep/Services/DBOperation/crud_operation.dart';
import 'package:examprep/model/product.model.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final ProductDb db = ProductDb();

  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. DYNAMIC HEADER: Shrinks and fades perfectly on scroll
          _buildSliverAppBar(),

          // 2. FORM CONTENT: Wrapped in a Sliver to move with the header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
              child: _buildFormCard(),
            ),
          ),
        ],
      ),
    );
  }

  // ================= DYNAMIC SLIVER HEADER =================
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 180.0,
      floating: false,
      pinned: true,
      elevation: 0,
      stretch: true, // Smooth stretching when pulling down
      backgroundColor: AppTheme.primary, // Color when pinned
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground, StretchMode.blurBackground],
        titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
        title: const Text(
          "New Product",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 20,
            letterSpacing: -0.5,
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.primaryGradient,
          ),
          child: Stack(
            children: [
              // Decorative background icon for premium feel
              Positioned(
                right: -20,
                bottom: -20,
                child: Icon(
                  Icons.add_shopping_cart_rounded,
                  size: 180,
                  color: Colors.white.withOpacity(0.12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= FORM CARD =================
  Widget _buildFormCard() {
    return Container(
      decoration: AppTheme.cardDecoration(),
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppTheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 12),
                const Text("Product Details", style: AppTheme.heading4),
              ],
            ),
            const SizedBox(height: 32),

            _buildField(
              label: "CATALOG ID",
              controller: _idController,
              hint: "PROD-001",
              icon: Icons.qr_code_scanner_rounded,
              validator: (v) => v!.isEmpty ? "ID required" : null,
            ),
            const SizedBox(height: 24),

            _buildField(
              label: "PRODUCT NAME",
              controller: _nameController,
              hint: "e.g. LAPTOPS",
              icon: Icons.inventory_2_outlined,
              validator: (v) => v!.isEmpty ? "Name required" : null,
            ),
            const SizedBox(height: 24),

            _buildField(
              label: "PRICE (USD)",
              controller: _priceController,
              hint: "0.00",
              icon: Icons.payments_outlined,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (v) => (v == null || double.tryParse(v) == null) ? "Invalid price" : null,
            ),
            const SizedBox(height: 24),

            _buildField(
              label: "DESCRIPTION",
              controller: _descController,
              hint: "Optional description...",
              icon: Icons.description_outlined,
              maxLines: 4,
            ),
            const SizedBox(height: 40),

            AppTheme.gradientButton(
              text: "SAVE TO INVENTORY",
              loading: _isSaving,
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: AppTheme.bodyText1,
      decoration: AppTheme.inputDecoration(
        label: label,
        hint: hint,
        icon: icon,
      ),
    );
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    try {
      final product = Product(
        id: _idController.text.trim(),
        name: _nameController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        description: _descController.text.trim(),
      );

      db.addProduct(product);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Product added successfully!"),
          backgroundColor: AppTheme.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: AppTheme.error, behavior: SnackBarBehavior.floating),
      );
    }
  }
}