part of 'edit_todo_bloc.dart';

@immutable
sealed class EditTodoEvent {}
class SendEditEvent extends EditTodoEvent{
  final int id;
final String todo;
  SendEditEvent( {required this.id,required this.todo});
}
