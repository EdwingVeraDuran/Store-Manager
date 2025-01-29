import 'package:store_manager/features/products/domain/entities/product.dart';
import 'package:store_manager/features/products/domain/repos/products_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProductsRepo implements ProductsRepo {
  final productsTable = Supabase.instance.client.from("products");

  @override
  Future<Product?> createProduct(Product product) async {
    try {
      final clientResponse =
          await productsTable.insert(product.toMap()).select();
      final productResponse = Product.fromMap(clientResponse.first);
      return productResponse;
    } catch (e) {
      throw Exception("Product creation failed: $e");
    }
  }

  @override
  Future<List<Product>> readProducts() async {
    try {
      final clientResponse = await productsTable.select();
      final List<Product> products =
          clientResponse.map((map) => Product.fromMap(map)).toList();
      return products;
    } catch (e) {
      throw Exception("Product selection failed: $e");
    }
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    try {
      final clientResponse = await productsTable
          .select("*")
          .or("code.ilike.%$query%,name.ilike.%$query%");
      final List<Product> products =
          clientResponse.map((map) => Product.fromMap(map)).toList();
      return products;
    } catch (e) {
      throw Exception("Product search failed: $e");
    }
  }

  @override
  Future<Product?> updateProduct(Product product) async {
    try {
      final clientResponse = await productsTable
          .update(product.toMap())
          .eq("id", product.id!)
          .select();
      final productResponse = Product.fromMap(clientResponse.first);
      return productResponse;
    } catch (e) {
      throw Exception("Product update failed: $e");
    }
  }

  @override
  Future<Product?> deleteProduct(int productId) async {
    try {
      final clientResponse =
          await productsTable.delete().eq("id", productId).select();
      final productResponse = Product.fromMap(clientResponse.first);
      return productResponse;
    } catch (e) {
      throw Exception("Product delete failed: $e");
    }
  }

  @override
  Future<bool> productCodeExists(String code) async {
    try {
      final clientResponse = await productsTable.select().eq("code", code);
      return clientResponse.isNotEmpty;
    } catch (e) {
      throw Exception("Product code check failed: $e");
    }
  }
}
