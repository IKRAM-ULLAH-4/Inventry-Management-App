import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examprep/model/product.model.dart';

class ProductDb {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void addProduct(Product product) {
    _db.collection('products').doc(product.id).set(product.toMap());
  }

  void updateProduct(Product product) {
    _db.collection('products').doc(product.id).update(product.toMap());
  }

  void deleteProduct(String id) {
    _db.collection('products').doc(id).delete();
  }

  Future<DocumentSnapshot> getProduct(String id) {
    return _db.collection('products').doc(id).get();
  }

  Stream<QuerySnapshot> getAllProducts() {
    return _db.collection('products').snapshots();
  }
}
