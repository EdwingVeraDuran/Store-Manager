import 'package:store_manager/features/clients/domain/entities/client.dart';

abstract class ClientsState {}

class ClientsInitial extends ClientsState {}

class ClientsLoading extends ClientsState {}

class ClientCreated extends ClientsState {
  final Client client;
  ClientCreated(this.client);
}

class ClientUpdated extends ClientsState {
  final Client client;
  ClientUpdated(this.client);
}

class ClientDeleted extends ClientsState {
  final Client client;
  ClientDeleted(this.client);
}

class ClientsList extends ClientsState {
  final List<Client> clients;
  ClientsList(this.clients);
}

class ClientsEmpty extends ClientsState {}

class ClientsError extends ClientsState {
  final String message;
  ClientsError(this.message);
}
