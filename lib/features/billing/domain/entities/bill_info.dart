import 'package:store_manager/features/billing/domain/entities/bill.dart';
import 'package:store_manager/features/billing/domain/entities/bill_detail.dart';

class BillInfo {
  final Bill bill;
  final List<BillDetail> billDetails;

  BillInfo({required this.bill, required this.billDetails});
}
