import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:todo_task/features/home/presentation/manger/post_todo_bloc/post_data_bloc.dart';
import '../../../../../core/utils/styles.dart';
class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key});
  @override
  Widget build(BuildContext context) {
    final bloc = KiwiContainer().resolve<PostDataBloc>();
    return TextField(
      controller: bloc.todoController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12.r)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r)
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(.6),
          hintText: 'What You Need To do?',
          helperStyle: Styles.textStyle14.copyWith(
            color: Colors.grey,

          ),
          suffixIcon: SizedBox(
            height: 70.h,
            width: 90.w,
            child: BlocBuilder(
              bloc:bloc,
              builder: (context, state) {
                if(state is PostDataLoading){
                  return SizedBox(
                      height: 5.h,
                      width: 5.w,
                      child: const Center(child: CircularProgressIndicator()));
                }
                else{
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12)
                        ),

                      ),
                    )
                    , onPressed: () {
                      bloc.add(PostTodoEvent());


                  },
                    child: Text('Add',
                      style: Styles.textStyle14.copyWith(
                          color: Colors.white
                      ),
                    ),

                  );
                }
              },
            ),
          )

      ),
    );
  }
}
