part of 'get__todos_bloc.dart';

@immutable
sealed class GetTodosState {}

final class GetTodosInitial extends GetTodosState {}
final class GetTodosLoading extends GetTodosState{}
final class GetTodosSuccess extends GetTodosState{
  final List<Todos> list;
  GetTodosSuccess({required this.list});
}
final class GetTodosFailure extends GetTodosState{}
final class GetTodosFromPaginationStateLoading extends GetTodosState{}
