import 'package:store_manager/features/clients/domain/entities/client.dart';

abstract class ClientsRepo {
  Future<Client?> createClient(Client client);
  Future<List<Client>> readClients();
  Future<List<Client>> searchClients(String query);
  Future<Client?> updateClient(Client client);
  Future<Client?> deleteClient(int clientId);
  Future<bool> clientPhoneExists(String code);
}
