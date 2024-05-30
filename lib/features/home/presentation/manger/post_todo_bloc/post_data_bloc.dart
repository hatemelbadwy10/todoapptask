import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:todo_task/core/utils/dio_helper.dart';
import 'package:todo_task/core/utils/helper_methods.dart';
import 'package:hive/hive.dart';
import '../../../data/models/todo_model.dart';

part 'post_data_event.dart';
part 'post_data_state.dart';

class PostDataBloc extends Bloc<PostDataEvent, PostDataState> {
  PostDataBloc() : super(PostDataInitial()) {
    on<PostTodoEvent>(postTodo);
  }
  final todoController = TextEditingController();

  void postTodo(PostTodoEvent event, Emitter<PostDataState> emitter) async {
    emit(PostDataLoading());
    final response = await DioHelper().sendToServer(
      url: 'todos/add',
      body: {
        'todo': todoController.text,
        'completed': false,
        'userId': 1,
      },
    );

    if (response.success) {
      final newTodo = Todos(
        id: response.response!.data['id'],
        todo: todoController.text,
        completed: false,
        userId: 1,
      );

      var todosBox = await Hive.openBox<TodoModel>('todosBox');
      var todoModel = TodoModel(
        todos: [newTodo], // Wrap the newTodo in a list as todos expects List<Todos>
        limit: 0, // You can set limit and total to appropriate values
        total: 0,
      );
      await todosBox.add(todoModel);

      todoController.clear();
      emit(PostDataSuccess());
    } else {
      emit(PostDataFailure());
    }
  }
}
