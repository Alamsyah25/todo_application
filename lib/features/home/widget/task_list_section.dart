import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/features/home/widget/task_list_shimmer.dart';

import '../../../common/constants/colors.dart';
import '../../../common/style/text_style.dart';
import '../view_model/home_view_model.dart';
import 'task_item_section.dart';

class TaskListSection extends StatelessWidget {
  const TaskListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today Task',
          style:
              TextStyleTheme.current.bodyText2Heavy.copyWith(color: kPrimary),
        ),
        SizedBox(
          height: 12.w,
        ),
        Builder(
          builder: (context) {
            final taskList = context.select((HomeViewModel vm) => vm.taskList);
            final isLoading =
                context.select((HomeViewModel vm) => vm.isLoading);

            if (isLoading) {
              return const TaskListShimmer();
            }

            if (taskList.isEmpty) {
              return Center(
                child: Image.asset(
                  'assets/empty-list.png',
                  height: 200.w,
                ),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                final item = taskList[index];
                return TaskItemSection(item: item);
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 12.w,
                );
              },
            );
          },
        )
      ],
    );
  }
}
