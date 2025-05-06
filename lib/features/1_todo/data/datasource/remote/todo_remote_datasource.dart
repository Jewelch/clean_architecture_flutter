import 'package:jch_requester/generic_requester.dart';

import '../../models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<TodosListModel?> getTodos();
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final RequestPerformer _apiClient;

  TodoRemoteDataSourceImpl({required RequestPerformer requestPerformer}) : _apiClient = requestPerformer;

  @override
  Future<TodosListModel?> getTodos() async {
    return await _apiClient.performDecodingRequest(
      method: RestfulMethods.get,
      path: 'todos',
      decodableModel: TodosListModel(),
    );
  }
}
