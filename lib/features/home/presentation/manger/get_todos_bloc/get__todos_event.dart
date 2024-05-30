part of 'get__todos_bloc.dart';

@immutable
sealed class GetTodosEvent {}
class GetDataEvent extends GetTodosEvent{}
class GetDataPaginationEvent extends GetTodosEvent{}
