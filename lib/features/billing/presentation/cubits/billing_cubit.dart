import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_manager/features/billing/domain/entities/bill.dart';
import 'package:store_manager/features/billing/domain/entities/bill_info.dart';
import 'package:store_manager/features/billing/domain/entities/cart_item.dart';
import 'package:store_manager/features/billing/domain/repos/billing_repo.dart';
import 'package:store_manager/features/billing/presentation/cubits/billing_state.dart';

class BillingCubit extends Cubit<BillingState> {
  final BillingRepo billingRepo;

  BillingCubit({required this.billingRepo}) : super(BillingInitial());

  Future<void> createBill(Bill bill, List<CartItem> items) async {
    try {
      final clientResponse = await billingRepo.createBill(bill, items);

      if (clientResponse != null) {
        emit(BillCreated(clientResponse));
        await readBills();
      }
    } catch (e) {
      emit(BillsError("Error al crear factura: $e"));
    }
  }

  Future<void> readBills() async {
    try {
      emit(BillsLoading());
      final clientResponse = await billingRepo.readBills();

      clientResponse.isEmpty
          ? emit(BillsEmpty())
          : emit(BillsList(clientResponse));
    } catch (e) {
      emit(BillsError("Error al leer facturas $e"));
    }
  }

  Future<void> readBillDetails(Bill bill) async {
    try {
      final billDetails = await billingRepo.readBillDetails(bill.id!);

      final BillInfo billInfo = BillInfo(bill: bill, billDetails: billDetails);

      emit(BillDetails(billInfo));
    } catch (e) {
      emit(BillsError("Error al leer datos de factura: $e"));
    }
  }

  Future<void> searchBills(String query) async {
    if (query.isEmpty) readBills();
    try {
      emit(BillsLoading());

      final clientResponse = await billingRepo.searchBills(query);

      clientResponse.isEmpty
          ? emit(BillsEmpty())
          : emit(BillsList(clientResponse));
    } catch (e) {
      emit(BillsError("Error al buscar facturas: $e"));
    }
  }

  Future<void> updateBill(BillInfo billInfo) async {
    try {
      final clientResponse = await billingRepo.updateBill(billInfo);

      if (clientResponse != null) {
        emit(BillUpdated(clientResponse));
        await readBills();
      }
    } catch (e) {
      emit(BillsError("Error al acutalizar factura: $e"));
    }
  }

  Future<void> deleteBill(Bill bill) async {
    try {
      final clientResponse = await billingRepo.deleteBill(bill);

      if (clientResponse != null) {
        emit(BillUpdated(clientResponse));
        await readBills();
      }
    } catch (e) {
      emit(BillsError("Error al eliminar factura: $e"));
    }
  }
}
