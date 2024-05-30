import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:todo_task/features/home/presentation/manger/delete_todo_bloc/delete_todo_bloc.dart';
import 'package:todo_task/features/home/presentation/manger/edit_todo_bloc/edit_todo_bloc.dart';
import '../../../../../core/utils/styles.dart';
import '../../../data/models/todo_model.dart';
import '../../manger/hidden_cubit/hidden_cubit.dart';
import 'custom_drop_down_item.dart';

class ListViewItem extends StatefulWidget {
  const ListViewItem({super.key, required this.todos,});

  final Todos todos;

  @override
  ListViewItemState createState() => ListViewItemState();
}

class ListViewItemState extends State<ListViewItem> {
  bool isEditing = false;
  late TextEditingController _controller;
  late String newTodo;
  final deleteBloc = KiwiContainer().resolve<DeleteTodoBloc>();
  final editTodo = KiwiContainer().resolve<EditTodoBloc>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.todos.todo);
    newTodo = widget.todos.todo;
  }

  @override
  void dispose() {
    _controller.dispose();
    editTodo.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isEditing
                  ? BlocBuilder(
                bloc: editTodo,
                builder: (context, editState) {
                  if (editState is EditTodoLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return Flexible(
                      child: TextField(
                        controller: _controller,
                        style: Styles.textStyle14,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter new text',
                        ),
                        onSubmitted: (newValue) {
                          setState(() {
                            newTodo = newValue;
                            isEditing = false;
                            editTodo.add(
                              SendEditEvent(
                                id: widget.todos.id,
                                todo: newValue,
                              ),
                            );
                          });
                        },
                      ),
                    );
                  }
                },
              )
                  : Flexible(
                child: Text(
                  newTodo,
                  style: Styles.textStyle14,
                ),
              ),
              PopupMenuButton(
                icon: Icon(
                  Icons.more_horiz_outlined,
                  size: 12.r,
                  color: Colors.grey,
                ),
                onSelected: (value) {
                  if (value == 'edit') {
                    setState(() {
                      isEditing = true;
                    });
                  } else if (value == 'delete') {
                    deleteBloc.add(DeleteEvent(id: widget.todos.id));
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: 'edit',
                      child: CustomDrodDownItem(
                        color: Colors.grey,
                        text: 'Edit Todo',
                        iconData: Icons.edit,
                        onTap: () {
                          Navigator.of(context).pop(); // Close the menu
                          setState(() {
                            isEditing = true;
                          });
                        },
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: BlocBuilder(
                        bloc: deleteBloc,
                        builder: (BuildContext context, state) {
                          if (state is DeleteTodoLoading) {
                            return const CircularProgressIndicator();
                          } else {
                            return  CustomDrodDownItem(
                                  color: Colors.red,
                                  text: 'Delete',
                                  iconData: Icons.delete,
                                  onTap: () {
                                    context.read<HiddenItemsCubit>().hideItem(
                                        widget.todos.id-1);
                                    Navigator.of(context).pop(); // Close the menu
                                    deleteBloc.add(
                                        DeleteEvent(id: widget.todos.id));
                                  },

                            );
                          }
                        },
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
