import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_task/core/utils/dio_helper.dart';
part 'delete_todo_event.dart';
part 'delete_todo_state.dart';

class DeleteTodoBloc extends Bloc<DeleteTodoEvent, DeleteTodoState> {
  DeleteTodoBloc() : super(DeleteTodoInitial()) {
    on<DeleteEvent>(deleteTodo);
  }
  void deleteTodo(DeleteEvent event,Emitter<DeleteTodoState>emitter)async{
    emit(DeleteTodoLoading());
    final response =await DioHelper().removeFromServer(url: 'todos/${event.id}');
    if(response.success){
      emit(DeleteTodoSuccess());
    }
    else{
      emit(DeleteTodoFailure());
    }
  }
}
