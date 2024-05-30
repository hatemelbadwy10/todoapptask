part of 'edit_todo_bloc.dart';

@immutable
sealed class EditTodoState {}

final class EditTodoInitial extends EditTodoState {}
final class EditTodoSuccess extends EditTodoState {}
final class EditTodoFailure extends EditTodoState {}
final class EditTodoLoading extends EditTodoState {}
