import 'package:kiwi/kiwi.dart';
import 'package:todo_task/core/utils/dio_helper.dart';
import 'package:todo_task/features/auth/presentation/manger/login_bloc/login_bloc.dart';
import 'package:todo_task/features/home/presentation/manger/delete_todo_bloc/delete_todo_bloc.dart';
import 'package:todo_task/features/home/presentation/manger/edit_todo_bloc/edit_todo_bloc.dart';
import 'package:todo_task/features/home/presentation/manger/get_todos_bloc/get__todos_bloc.dart';
import 'package:todo_task/features/home/presentation/manger/post_todo_bloc/post_data_bloc.dart';

void initKiwi(){
  KiwiContainer container =KiwiContainer();
  container.registerFactory((container) => DioHelper());
  container.registerFactory((container) => GetTodosBloc());
  container.registerFactory((container) => PostDataBloc());
container.registerFactory((container) => DeleteTodoBloc());
container.registerFactory((container) => EditTodoBloc());
  container.registerFactory((container) => LoginBloc());

}