import 'package:store_manager/features/products/domain/entities/product.dart';

abstract class ProductsRepo {
  Future<Product?> createProduct(Product product);
  Future<List<Product>> readProducts();
  Future<List<Product>> searchProducts(String query);
  Future<Product?> getProductByCode(String code);
  Future<Product?> updateProduct(Product product);
  Future<Product?> deleteProduct(int productId);
  Future<bool> productCodeExists(String code);
}
