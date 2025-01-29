import 'package:store_manager/features/products/domain/entities/product.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductCreated extends ProductsState {
  final Product product;
  ProductCreated(this.product);
}

class ProductUpdated extends ProductsState {
  final Product product;
  ProductUpdated(this.product);
}

class ProductDeleted extends ProductsState {
  final Product product;
  ProductDeleted(this.product);
}

class ProductsList extends ProductsState {
  final List<Product> products;
  ProductsList(this.products);
}

class ProductsEmpty extends ProductsState {}

class ProductsError extends ProductsState {
  final String message;
  ProductsError(this.message);
}
