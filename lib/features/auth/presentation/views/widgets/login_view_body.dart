import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:todo_task/core/utils/styles.dart';
import 'package:todo_task/features/auth/presentation/manger/login_bloc/login_bloc.dart';
import 'package:todo_task/features/auth/presentation/views/widgets/custom_login_button.dart';
import 'package:todo_task/features/auth/presentation/views/widgets/login_text_field.dart';
import 'package:todo_task/features/home/presentation/views/widgets/background_widget.dart';
class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}
final _form = GlobalKey<FormState>();

final bloc = KiwiContainer().resolve<LoginBloc>();

class _LoginViewBodyState extends State<LoginViewBody> {
  @override
  Widget build(BuildContext context) {
    return   BackgroundWidget(widget: Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.h),
      child: Form(
        key: _form,
        child: ListView(
          children: [
            SizedBox(height: 150.h,),
            Center(
              child: Text('Login',
              style: Styles.textStyle30,
              ),
            ),
           SizedBox(height: 40.h,),
            CustomLoginTextField(controller: bloc.userNameController,hint: 'email', icon: Icon(Icons.person,color: Colors.black,), validatorWord: 'email'),
            SizedBox(
              height: 38.h,
            ),
             CustomLoginTextField(controller: bloc.passwordController,hint: 'password', icon: Icon(Icons.lock,color: Colors.black,), validatorWord: 'password',
            obscureText: true,
            ),
            SizedBox(
              height: 30.h,
            ),
            BlocBuilder(
              bloc: bloc,
  builder: (context, state) {
if(state is LoginLoading){
  return SizedBox(
      height: 30.h,
      width: 15.w,
      child: const Center(child: CircularProgressIndicator()));
}
else{
  return CustomButton(onPress: (){
    if(_form.currentState!.validate()){

      bloc.add(LoginUserDataEvent());
    }

  });
}
  },
)
          ],
        ),
      ),
    ),


    );
  }
}
