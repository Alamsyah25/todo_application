import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/features/home/widget/task_overview_shimmer.dart';

import '../../../common/constants/colors.dart';
import '../../../common/style/text_style.dart';
import '../view_model/home_view_model.dart';

class TaskOverviewSection extends StatelessWidget {
  const TaskOverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Task Overview',
          style:
              TextStyleTheme.current.bodyText2Heavy.copyWith(color: kPrimary),
        ),
        SizedBox(
          height: 8.w,
        ),
        Builder(
          builder: (context) {
            final todoLength =
                context.select((HomeViewModel vm) => vm.todoLength);

            final onGoingLength =
                context.select((HomeViewModel vm) => vm.ongoingLength);

            final doneLength =
                context.select((HomeViewModel vm) => vm.doneLength);

            final isLoading =
                context.select((HomeViewModel vm) => vm.isLoading);

            if (isLoading) {
              return const TaskOverviewShimmer();
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 8.w, bottom: 4.w),
                    margin: EdgeInsets.only(right: 4.w),
                    decoration: BoxDecoration(
                      color: kPrimaryOpacity2,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Column(
                      children: [
                        Text(
                          todoLength.toString(),
                          style: TextStyleTheme.current.bodyText2Light
                              .copyWith(color: kNeutral0, height: 1),
                        ),
                        Text(
                          'Todo',
                          style: TextStyleTheme.current.bodyText2Heavy
                              .copyWith(color: kNeutral0, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 8.w,
                      bottom: 4.w,
                    ),
                    margin: EdgeInsets.only(left: 4.w),
                    decoration: BoxDecoration(
                      color: kSecondaryOpacity2,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Column(
                      children: [
                        Text(
                          onGoingLength.toString(),
                          style: TextStyleTheme.current.bodyText2Light
                              .copyWith(color: kNeutral0, height: 1),
                        ),
                        Text(
                          'Ongoing',
                          style: TextStyleTheme.current.bodyText2Heavy
                              .copyWith(color: kNeutral0, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 8.w, bottom: 4.w),
                    margin: EdgeInsets.only(left: 8.w),
                    decoration: BoxDecoration(
                      color: kSuccessOpacity2,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Column(
                      children: [
                        Text(
                          doneLength.toString(),
                          style: TextStyleTheme.current.bodyText2Light
                              .copyWith(color: kNeutral0, height: 1),
                        ),
                        Text(
                          'Done',
                          style: TextStyleTheme.current.bodyText2Heavy
                              .copyWith(color: kNeutral0, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
