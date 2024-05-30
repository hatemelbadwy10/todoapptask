import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import 'package:todo_task/core/utils/styles.dart';
import 'package:todo_task/features/home/presentation/manger/get_todos_bloc/get__todos_bloc.dart';
import 'package:todo_task/features/home/presentation/views/widgets/background_widget.dart';
import 'package:todo_task/features/home/presentation/views/widgets/custom_textfield.dart';
import 'package:todo_task/features/home/presentation/views/widgets/list_view_item.dart';
import 'package:todo_task/features/home/presentation/views/widgets/logo_widget.dart';

import '../../manger/hidden_cubit/hidden_cubit.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

final bloc = KiwiContainer().resolve<GetTodosBloc>()
  ..add(GetDataEvent());

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {



    return BackgroundWidget(

      widget:
      BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is GetTodosLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is GetTodosSuccess) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: Column(
                  children: [
                    const LogoWidget(),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text('Tasks', style: Styles.textStyle14,)),
                    Expanded(
                      child: BlocBuilder<HiddenItemsCubit, List<int>>(
                        builder: (context, hiddenItems) {
                          return NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification sn)
                              {

                              if(sn is ScrollUpdateNotification &&
                                  sn.metrics.pixels == sn.metrics.maxScrollExtent){
                                isConnected().then((c){
                                  if(c){
                                    bloc.add(GetDataPaginationEvent());
                                  }
                                });
                              }
                              return true;

                            },
                            child: ListView.builder(
                                itemCount: bloc.model.length
                                , itemBuilder: (context, index) {
                              if (hiddenItems.contains(index)) {
                                return const SizedBox.shrink();
                              }else {
                              return Column(
                                children: [
                                  ListViewItem(todos: state.list[index]),
                                 // if(state is GetTodosLoading&& bloc.model.length==index) const Center(child: CircularProgressIndicator())
                                ],
                              );
                            }}),
                          );
                        },
                      ),
                    ),
                    const CustomTextField()

                  ],
                ),
              ),
            );
          }
          else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

