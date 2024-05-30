import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_task/core/utils/helper_methods.dart';
import 'package:todo_task/features/home/presentation/views/home_view.dart';
import '../../../../../core/utils/cach_helper.dart';
import '../../../../../core/utils/dio_helper.dart';
import '../../../data/models/user_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUserDataEvent>(login);
  }
  final userNameController = TextEditingController();
  final passwordController= TextEditingController();

  void login(LoginUserDataEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final response = await DioHelper().sendToServer(
        url: 'auth/login',
        body: {
          "username": userNameController.text,
          "password": passwordController.text,
          "expiresInMins": 30
        },
      );

      if (response.success) {
        await CacheHelper.saveLoginData(UserModel.fromJson(response.response!.data));
        navigateTo(
          const HomeView(),
        );
        emit(LoginSuccess());
      } else {
        emit(LoginFailure());
      }
    } catch (e) {
      emit(LoginFailure());
    }
  }
}
