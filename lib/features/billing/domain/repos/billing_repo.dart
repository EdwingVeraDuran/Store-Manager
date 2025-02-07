import 'package:store_manager/features/billing/domain/entities/bill.dart';
import 'package:store_manager/features/billing/domain/entities/bill_detail.dart';
import 'package:store_manager/features/billing/domain/entities/bill_info.dart';
import 'package:store_manager/features/billing/domain/entities/cart_item.dart';

abstract class BillingRepo {
  Future<Bill?> createBill(Bill bill, List<CartItem> items);
  Future<List<Bill>> readBills();
  Future<List<BillDetail>> readBillDetails(int billId);
  Future<List<Bill>> searchBills(String query);
  Future<Bill?> updateBill(BillInfo billInfo);
  Future<Bill?> deleteBill(Bill bill);
}
