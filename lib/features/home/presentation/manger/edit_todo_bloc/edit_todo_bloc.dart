import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:todo_task/core/utils/dio_helper.dart';
import 'package:hive/hive.dart';
import '../../../data/models/todo_model.dart';

part 'edit_todo_event.dart';
part 'edit_todo_state.dart';

class EditTodoBloc extends Bloc<EditTodoEvent, EditTodoState> {
  EditTodoBloc() : super(EditTodoInitial()) {
    on<SendEditEvent>(sendEdit);
  }

  void sendEdit(SendEditEvent event, Emitter<EditTodoState> emitter) async {
    emit(EditTodoLoading());
    final response = await DioHelper().sendToServer(
      url: 'todos/${event.id}',
      body: {
        'todo': event.todo,
        '_method': 'PUT',
      },
    );
    if (response.success) {
      var todosBox = await Hive.openBox<TodoModel>('todosBox');
      var todoModel = todosBox.get('todos');

      if (todoModel != null) {
        var todos = todoModel.todos;
        var editedTodo = todos.firstWhere((todo) => todo.id == event.id);
        if (editedTodo != null) {
          editedTodo.todo = event.todo;
          await todosBox.put('todos', todoModel);
        }
      }

      emit(EditTodoSuccess());
    } else {
      emit(EditTodoFailure());
    }
  }
}
