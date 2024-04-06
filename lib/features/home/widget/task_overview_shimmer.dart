import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/constants/colors.dart';

class TaskOverviewShimmer extends StatelessWidget {
  const TaskOverviewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kNeutral50,
      highlightColor: kNeutral100,
      child: SizedBox(
        height: 64.w,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 8.w, bottom: 4.w),
                margin: EdgeInsets.only(right: 4.w),
                decoration: BoxDecoration(
                  color: kNeutral0,
                  borderRadius: BorderRadius.circular(4.r),
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
                  color: kNeutral0,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 8.w, bottom: 4.w),
                margin: EdgeInsets.only(left: 8.w),
                decoration: BoxDecoration(
                  color: kNeutral0,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
