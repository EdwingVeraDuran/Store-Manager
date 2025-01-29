import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_manager/features/products/domain/entities/product.dart';
import 'package:store_manager/features/products/domain/repos/products_repo.dart';
import 'package:store_manager/features/products/presentation/cubits/products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo productsRepo;

  ProductsCubit({required this.productsRepo}) : super(ProductsInitial());

  Future<void> createProduct(Product product) async {
    try {
      final productResponse = await productsRepo.createProduct(product);

      if (productResponse != null) {
        emit(ProductCreated(productResponse));
        await readProducts();
      }
    } catch (e) {
      emit(ProductsError("Error al crear producto: $e"));
    }
  }

  Future<void> readProducts() async {
    try {
      emit(ProductsLoading());
      final products = await productsRepo.readProducts();

      products.isEmpty ? emit(ProductsEmpty()) : emit(ProductsList(products));
    } catch (e) {
      emit(ProductsError("Error al leer productos: $e"));
    }
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) readProducts();
    try {
      emit(ProductsLoading());
      final products = await productsRepo.searchProducts(query);

      products.isEmpty ? emit(ProductsEmpty()) : emit(ProductsList(products));
    } catch (e) {
      emit(ProductsError("Error al buscar productos: $e"));
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      final productResponse = await productsRepo.updateProduct(product);

      if (productResponse != null) {
        emit(ProductUpdated(productResponse));
        await readProducts();
      }
    } catch (e) {
      emit(ProductsError("Error al actualizar producto: $e"));
    }
  }

  Future<void> deleteProduct(int productId) async {
    try {
      final clientResponse = await productsRepo.deleteProduct(productId);
      if (clientResponse != null) {
        emit(ProductDeleted(clientResponse));
        await readProducts();
      }
    } catch (e) {
      emit(ProductsError("Error al eliminar producto: $e"));
    }
  }

  Future<bool> productCodeExists(String code) async =>
      await productsRepo.productCodeExists(code);
}
