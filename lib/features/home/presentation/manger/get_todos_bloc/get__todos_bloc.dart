import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:todo_task/core/utils/dio_helper.dart';
import 'package:hive/hive.dart';
import '../../../data/models/todo_model.dart';

part 'get__todos_event.dart';
part 'get__todos_state.dart';

class GetTodosBloc extends Bloc<GetTodosEvent, GetTodosState> {
  GetTodosBloc() : super(GetTodosInitial()) {
    on<GetDataEvent>(_getTodos);
    on<GetDataPaginationEvent>(_fPagination);
  }

  List<Todos> model = [];
  int limit = 20;

  Future<void> _getTodos(GetDataEvent event, Emitter<GetTodosState> emitter) async {
    emit(GetTodosLoading());

    bool internetAvailable = await isConnected();

    if (internetAvailable) {
      final response = await repo();
      if (response.success) {
        model = List<Todos>.from(
            response.response!.data["todos"].map((x) => Todos.fromJson(x)));

        // Save to Hive
        var box = await Hive.openBox<TodoModel>('todosBox');
        var todoModel = TodoModel(todos: model, limit: limit, total: response.response!.data['total']);
        await box.put('todos', todoModel);

        emit(GetTodosSuccess(list: model));
      } else {
        emit(GetTodosFailure());
      }
    } else {
      // Fetch from Hive
      TodoModel? todoModel = await getDataFromHive();
      if (todoModel != null) {
        model = todoModel.todos;
        emit(GetTodosSuccess(list: model));
      } else {
        emit(GetTodosFailure());
      }
    }
  }

  List<Todos> tempList = [];

  Future<void> _fPagination(
      GetDataPaginationEvent event, Emitter<GetTodosState> emit) async {
    // emit(GetTodosFromPaginationStateLoading());
    CustomResponse response = await repo();
    if (response.success) {
      tempList = List<Todos>.from(
          response.response!.data["todos"].map((x) => Todos.fromJson(x)));
      model.addAll(tempList);

      // Update Hive with new data
      var box = await Hive.openBox<TodoModel>('todosBox');
      var todoModel = TodoModel(todos: model, limit: limit, total: response.response!.data['total'],);
      await box.put('todos', todoModel);

      emit(GetTodosSuccess(list: model));
    } else {
      emit(GetTodosFailure());
    }
  }

  Future<CustomResponse> repo() async {
    CustomResponse response = await DioHelper().getFromServer(url: 'todos?limit=$limit&skip=${model.length}');
    return response;
  }


  Future<TodoModel?> getDataFromHive() async {
    var box = await Hive.openBox<TodoModel>('todosBox');
    return box.get('todos');
  }
}

Future<bool> isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult != ConnectivityResult.none;
}