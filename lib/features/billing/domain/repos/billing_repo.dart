import 'package:store_manager/features/billing/domain/entities/bill.dart';
import 'package:store_manager/features/billing/domain/entities/bill_detail.dart';

abstract class BillingRepo {
  Future<Bill?> createBill(Bill bill, List<BillDetail> billDetails);
  Future<List<Bill>> readBills();
  Future<List<BillDetail>> readBillDetails(int billId);
  Future<List<Bill>> searchBills(String query);
  Future<Bill?> updateBill(Bill bill, List<BillDetail> billDetails);
  Future<Bill?> deleteBill(Bill bill);
}
