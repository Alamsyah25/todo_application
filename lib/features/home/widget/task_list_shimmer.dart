import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/constants/colors.dart';

class TaskListShimmer extends StatelessWidget {
  const TaskListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kNeutral50,
      highlightColor: kNeutral100,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 8, // Adjust the
        padding: EdgeInsets.zero, // count based on your needs
        itemBuilder: (context, index) {
          return Container(
            height: 64.w,
            width: 1.sw,
            decoration: BoxDecoration(
              color: kNeutral0,
              borderRadius: BorderRadius.circular(4.r),
            ),
            margin: EdgeInsets.only(bottom: 10.w),
          );
        },
      ),
    );
  }
}
