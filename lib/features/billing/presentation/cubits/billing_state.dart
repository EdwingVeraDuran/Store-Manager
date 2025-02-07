import 'package:store_manager/features/billing/domain/entities/bill.dart';
import 'package:store_manager/features/billing/domain/entities/bill_info.dart';

abstract class BillingState {}

class BillingInitial extends BillingState {}

class BillsLoading extends BillingState {}

class BillCreated extends BillingState {
  final Bill bill;
  BillCreated(this.bill);
}

class BillUpdated extends BillingState {
  final Bill bill;
  BillUpdated(this.bill);
}

class BillDeleted extends BillingState {
  final Bill bill;
  BillDeleted(this.bill);
}

class BillDetails extends BillingState {
  final BillInfo billInfo;

  BillDetails(this.billInfo);
}

class BillsList extends BillingState {
  final List<Bill> bills;
  BillsList(this.bills);
}

class BillsEmpty extends BillingState {}

class BillsError extends BillingState {
  final String message;
  BillsError(this.message);
}
