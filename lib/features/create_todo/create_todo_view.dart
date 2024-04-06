import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/constants/colors.dart';
import '../../common/style/text_style.dart';
import '../../common/widget/custom_text_field.dart';
import '../../common/widget/loading_state.dart';
import '../../core/base/mvvm.dart';
import '../../core/model/task_model.dart';
import 'repository/create_todo_respository.dart';
import 'view_model/create_todo_view_model.dart';

class CreateTodoView extends StatefulWidget {
  const CreateTodoView({super.key, required this.task});
  final Task? task;
  @override
  State<CreateTodoView> createState() => _CreateTodoViewState();
}

class _CreateTodoViewState extends State<CreateTodoView> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();

  Future<void> _onSubmit(BuildContext context) async {
    Task? data;

    if (widget.task != null) {
      data = await context.read<CreateTodoViewModel>().createTask();
    } else {
      data = await context.read<CreateTodoViewModel>().updateTask();
    }

    if (data != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Success',
              style: TextStyleTheme.current.bodyText2Heavy
                  .copyWith(color: kNeutral0),
            ),
            backgroundColor: kSuccess,
          ),
        );
        Navigator.pop(context);
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      titleController.text = widget.task?.taskName ?? '';
      descriptionController.text = widget.task?.description ?? '';
      dateController.text = widget.task?.dueDate ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isCreate = widget.task == null;
    return MvvmBuilder<CreateTodoViewModel>(
      viewModel: CreateTodoViewModel(
        createTodoRepository: CreateTodoRepository(),
        titleController: titleController,
        descriptionController: descriptionController,
        dateController: dateController,
      ),
      view: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(isCreate ? 'Create Task' : 'Update Task'),
          ),
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isCreate ? 'Create A Task' : 'Update a Task',
                      style: TextStyleTheme.current.bodyText1Heavy.copyWith(
                        color: kNeutral900,
                      ),
                    ),
                    SizedBox(
                      height: 12.w,
                    ),
                    CustomTextField(
                      textEditingController: titleController,
                      floatingLabel: 'Title',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 8.w,
                    ),
                    CustomTextField(
                      textEditingController: descriptionController,
                      floatingLabel: 'Description',
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 8.w,
                    ),
                    CustomTextField(
                      textEditingController: dateController,
                      floatingLabel: 'Date',
                      readOnly: true,
                      onTap: () {
                        _selectDate(context);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please choose the date';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 22.w,
                    ),
                    Builder(builder: (context) {
                      final isLoading = context
                          .select((CreateTodoViewModel vm) => vm.isLoading);
                      return SizedBox(
                        width: 1.sw,
                        height: 42.w,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return kPrimary;
                              },
                            ),
                            textStyle:
                                MaterialStateProperty.resolveWith<TextStyle>(
                              (states) => TextStyleTheme.current.bodyText2Heavy,
                            ),
                            shape: MaterialStateProperty.resolveWith<
                                OutlinedBorder>(
                              (Set<MaterialState> states) {
                                return RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: kPrimary,
                                    width: 1.w,
                                  ),
                                  borderRadius: BorderRadius.circular(4.r),
                                );
                              },
                            ),
                          ),
                          onPressed: () {
                            if (isLoading) return;

                            if (_formKey.currentState!.validate()) {
                              _onSubmit(context);
                            }
                          },
                          child: Builder(builder: (context) {
                            if (isLoading) {
                              return const LoadingState(
                                color: kNeutral0,
                              );
                            }
                            return Text(
                              isCreate ? 'Save Task' : 'Update Task',
                              style: TextStyleTheme.current.bodyText1Heavy
                                  .copyWith(
                                color: kNeutral0,
                              ),
                            );
                          }),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      key: const ValueKey('create-todo-view'),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final dateNow = DateTime.now();

    final firstDate = DateTime.now();

    final lastDate = DateTime(
      DateTime.now().year + 2,
    );

    final newSelectedDate = await showDatePicker(
      context: context,
      initialDate: dateNow,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (BuildContext context, child) {
        if (child != null) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: kPrimary,
                onPrimary: kNeutral0,
                surface: kPrimaryOpacity2,
                onSurface: kPrimary,
              ),
              // dialogBackgroundColor: kNeutral100,
            ),
            child: child,
          );
        }

        return Builder(
          builder: (context) {
            Future.delayed(
              const Duration(milliseconds: 350),
              () {
                Navigator.pop(context);
              },
            );
            return const SizedBox.shrink();
          },
        );
      },
    );

    if (newSelectedDate != null) {
      final outputFormat = DateFormat('yyyy-MM-dd');
      final date = outputFormat.format(newSelectedDate);
      dateController.text = date;
    }
  }
}
