part of 'delete_todo_bloc.dart';

@immutable
sealed class DeleteTodoEvent {}
class DeleteEvent extends DeleteTodoEvent{
  final int id;

  DeleteEvent({required this.id});
}
