import 'package:store_manager/features/clients/domain/entities/client.dart';
import 'package:store_manager/features/clients/domain/repos/clients_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClientsRepo implements ClientsRepo {
  final clientsTable = Supabase.instance.client.from("clients");

  @override
  Future<Client?> createClient(Client client) async {
    try {
      final clientResponse = await clientsTable.insert(client.toMap()).select();
      final response = Client.fromMap(clientResponse.first);
      return response;
    } catch (e) {
      throw Exception("Client creation failed: $e");
    }
  }

  @override
  Future<List<Client>> readClients() async {
    try {
      final clientResponse = await clientsTable.select();
      final List<Client> clients =
          clientResponse.map((map) => Client.fromMap(map)).toList();
      return clients;
    } catch (e) {
      throw Exception("Client selection failed: $e");
    }
  }

  @override
  Future<List<Client>> searchClients(String query) async {
    try {
      final clientResponse = await clientsTable
          .select("*")
          .or("phone.ilike.%$query%,name.ilike.%$query%");
      final List<Client> clients =
          clientResponse.map((map) => Client.fromMap(map)).toList();
      return clients;
    } catch (e) {
      throw Exception("Client search failed: $e");
    }
  }

  @override
  Future<Client?> updateClient(Client client) async {
    try {
      final clientResponse = await clientsTable
          .update(client.toMap())
          .eq("id", client.id!)
          .select();
      final response = Client.fromMap(clientResponse.first);
      return response;
    } catch (e) {
      throw Exception("Client update failed: $e");
    }
  }

  @override
  Future<Client?> deleteClient(int clientId) async {
    try {
      final clientResponse =
          await clientsTable.delete().eq("id", clientId).select();
      final response = Client.fromMap(clientResponse.first);
      return response;
    } catch (e) {
      throw Exception("Client deletion failed: $e");
    }
  }

  @override
  Future<bool> clientPhoneExists(String phone) async {
    try {
      final clientResponse = await clientsTable.select().eq("phone", phone);
      return clientResponse.isNotEmpty;
    } catch (e) {
      throw Exception("Client phone check failed: $e");
    }
  }
}
