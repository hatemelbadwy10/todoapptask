import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_task/core/utils/helper_methods.dart';
import 'package:todo_task/features/auth/presentation/views/login_view.dart';
import 'core/utils/cach_helper.dart';
import 'core/utils/kiwi.dart';
import 'features/home/presentation/manger/hidden_cubit/hidden_cubit.dart';
import 'features/home/presentation/views/home_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await CacheHelper.init();
  await Hive.initFlutter();
  await CacheHelper.initialiseHive();
  initKiwi();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(

      designSize: const Size(375, 812),

      child: BlocProvider(
        create: (context) => HiddenItemsCubit(),
        child:  MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          home:   CacheHelper.getToken().isNotEmpty? const HomeView(): const LoginView(),

        ),
      ),
    );
  }
}

