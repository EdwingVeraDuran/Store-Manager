import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_manager/features/clients/domain/entities/client.dart';
import 'package:store_manager/features/clients/domain/repos/clients_repo.dart';
import 'package:store_manager/features/clients/presentation/cubits/clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  final ClientsRepo clientsRepo;

  ClientsCubit({required this.clientsRepo}) : super(ClientsInitial());

  Future<void> createClient(Client client) async {
    try {
      final clientResponse = await clientsRepo.createClient(client);

      if (clientResponse != null) {
        emit(ClientCreated(clientResponse));
        await readClients();
      }
    } catch (e) {
      emit(ClientsError("Error al crear cliente: $e"));
    }
  }

  Future<void> readClients() async {
    try {
      emit(ClientsLoading());
      final clients = await clientsRepo.readClients();

      clients.isEmpty ? emit(ClientsEmpty()) : emit(ClientsList(clients));
    } catch (e) {
      emit(ClientsError("Error al leer clientes: $e"));
    }
  }

  Future<void> searchClients(String query) async {
    if (query.isEmpty) readClients();
    try {
      emit(ClientsLoading());
      final clients = await clientsRepo.searchClients(query);

      clients.isEmpty ? emit(ClientsEmpty()) : emit(ClientsList(clients));
    } catch (e) {
      emit(ClientsError("Error al buscar clientes: $e"));
    }
  }

  Future<void> updateClient(Client client) async {
    try {
      final clientResponse = await clientsRepo.updateClient(client);

      if (clientResponse != null) {
        emit(ClientUpdated(clientResponse));
        await readClients();
      }
    } catch (e) {
      emit(ClientsError("Error al actualizar cliente: $e"));
    }
  }

  Future<void> deleteClient(int clientId) async {
    try {
      final clientResponse = await clientsRepo.deleteClient(clientId);
      if (clientResponse != null) {
        emit(ClientDeleted(clientResponse));
        await readClients();
      }
    } catch (e) {
      emit(ClientsError("Error al eliminar cliente: $e"));
    }
  }

  Future<bool> clientPhoneExists(String code) async =>
      await clientsRepo.clientPhoneExists(code);
}
