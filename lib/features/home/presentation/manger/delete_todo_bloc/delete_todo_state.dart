part of 'delete_todo_bloc.dart';

@immutable
sealed class DeleteTodoState {}

final class DeleteTodoInitial extends DeleteTodoState {}
final class DeleteTodoSuccess extends DeleteTodoState {}
final class DeleteTodoFailure extends DeleteTodoState {}
final class DeleteTodoLoading extends DeleteTodoState {}
