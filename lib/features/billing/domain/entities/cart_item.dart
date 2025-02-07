import 'package:store_manager/features/products/domain/entities/product.dart';

class CartItem {
  final Product product;
  int amount;

  CartItem({required this.product, required this.amount});

  void increment() => amount += 1;

  void decrement() => amount -= 1;
}
