import 'package:jch_requester/generic_requester.dart';

import '../../../../../core/error/exceptions.dart';
import '../../models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<TodosListModel?> getTodos();
  Future<TodoModel?> deleteTodo(int id);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final RequestPerformer _apiClient;

  TodoRemoteDataSourceImpl({required RequestPerformer requestPerformer}) : _apiClient = requestPerformer;

  @override
  Future<TodosListModel?> getTodos() async {
    try {
      return await _apiClient.performDecodingRequest(
        debugIt: false,
        method: RestfulMethods.get,
        path: 'todos',
        decodableModel: TodosListModel(),
      );
    } catch (e) {
      throw ServerException(e);
    }
  }

  @override
  Future<TodoModel?> deleteTodo(int id) async {
    try {
      return (await _apiClient.performDecodingRequest(
        debugIt: true,
        method: RestfulMethods.delete,
        path: 'todos/$id',
        decodableModel: PatchingModel(),
      ));
    } catch (error) {
      throw ServerException(error);
    }
  }
}
