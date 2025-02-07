import 'package:store_manager/features/billing/domain/entities/bill.dart';
import 'package:store_manager/features/billing/domain/entities/bill_detail.dart';
import 'package:store_manager/features/billing/domain/entities/bill_info.dart';
import 'package:store_manager/features/billing/domain/entities/cart_item.dart';
import 'package:store_manager/features/billing/domain/repos/billing_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseBillingRepo implements BillingRepo {
  final billsTable = Supabase.instance.client.from("bills");
  final billDetailsTable = Supabase.instance.client.from("bill_details");

  @override
  Future<Bill?> createBill(Bill bill, List<CartItem> items) async {
    try {
      final clientResponse = await billsTable.insert(bill.toMap()).select();
      final billResponse = Bill.fromMap(clientResponse.first);
      await billDetailsTable.insert(items
          .map((item) => BillDetail(
              billId: billResponse.id!,
              productId: item.product.id!,
              amount: item.amount,
              price: item.product.sellPrice))
          .toList());
      final response = Bill.fromMap(clientResponse.first);
      return response;
    } catch (e) {
      throw Exception("Bill creation failed: $e");
    }
  }

  @override
  Future<List<Bill>> readBills() async {
    try {
      final clientResponse = await billsTable.select();
      final response = clientResponse.map((e) => Bill.fromMap(e)).toList();
      return response;
    } catch (e) {
      throw Exception("Bill selection failed: $e");
    }
  }

  @override
  Future<List<BillDetail>> readBillDetails(int billId) async {
    try {
      final clientResponse =
          await billDetailsTable.select().eq("bill_id", billId);
      final response =
          clientResponse.map((e) => BillDetail.fromMap(e)).toList();
      return response;
    } catch (e) {
      throw Exception("Bill details selection failed: $e");
    }
  }

  @override
  Future<List<Bill>> searchBills(String query) async {
    try {
      final clientResponse = await billsTable
          .select()
          .or("client_phone.ilike.%$query%,id.ilike.%$query%");
      final response = clientResponse.map((e) => Bill.fromMap(e)).toList();
      return response;
    } catch (e) {
      throw Exception("Bill search failed: $e");
    }
  }

  @override
  Future<Bill?> updateBill(BillInfo billInfo) async {
    try {
      final clientResponse = await billsTable
          .update(billInfo.bill.toMap())
          .eq("bill_id", billInfo.bill.id!)
          .select();
      billInfo.billDetails.map((e) async =>
          await billDetailsTable.update(e.toMap()).eq("id", e.id!));
      final response = Bill.fromMap(clientResponse.first);
      return response;
    } catch (e) {
      throw Exception("Bill update failed: $e");
    }
  }

  @override
  Future<Bill?> deleteBill(Bill bill) async {
    try {
      final clientResponse =
          await billsTable.delete().eq("id", bill.id!).select();
      await billDetailsTable.delete().eq("bill_id", bill.id!);
      final response = Bill.fromMap(clientResponse.first);
      return response;
    } catch (e) {
      throw Exception("Bill deletion failed: $e");
    }
  }
}
