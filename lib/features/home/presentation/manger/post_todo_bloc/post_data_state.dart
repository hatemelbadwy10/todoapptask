part of 'post_data_bloc.dart';

@immutable
sealed class PostDataState {}

final class PostDataInitial extends PostDataState {}
final class PostDataLoading extends PostDataState {}
final class PostDataSuccess extends PostDataState {}
final class PostDataFailure extends PostDataState {}
