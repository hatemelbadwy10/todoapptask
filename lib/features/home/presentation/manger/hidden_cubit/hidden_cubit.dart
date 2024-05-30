import 'package:bloc/bloc.dart';

class HiddenItemsCubit extends Cubit<List<int>> {
  HiddenItemsCubit() : super([]);

  void hideItem(int index) {
    final updatedList = List<int>.from(state);
    updatedList.add(index);
    emit(updatedList);
  }

  void showItem(int index) {
    final updatedList = List<int>.from(state);
    updatedList.remove(index);
    emit(updatedList);
  }
}