import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

import '../../../common/constants/colors.dart';
import '../../../common/constants/constants.dart';
import '../../../common/style/text_style.dart';
import '../../../core/model/task_model.dart';
import '../../../core/router/route_list.dart';
import '../view_model/home_view_model.dart';

class TaskItemSection extends StatelessWidget {
  const TaskItemSection({super.key, required this.item});
  final Task item;

  @override
  Widget build(BuildContext context) {
    Color? badgeColor;

    switch (item.status?.status) {
      case Constants.todo:
        badgeColor = kPrimaryOpacity2;
        break;
      case Constants.onGoing:
        badgeColor = kSecondaryOpacity2;
        break;
      case Constants.done:
        badgeColor = kSuccessOpacity2;
        break;
    }

    return GestureDetector(
      onTap: () {
        _showTodoDetailBottomSheet(
          context: context,
          item: item,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: kNeutral0,
          boxShadow: const [
            BoxShadow(color: kNeutral200, offset: Offset(0, 1), blurRadius: 1),
          ],
          borderRadius: BorderRadius.circular(
            8.r,
          ),
        ),
        height: 80.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 5.w,
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  bottomLeft: Radius.circular(8.r),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 6.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 1.w,
                      horizontal: 8.w,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      item.status?.status?.toUpperCase() ?? '',
                      style: TextStyleTheme.current.bodyText4Light.copyWith(
                        color: kNeutral0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.w,
                  ),
                  Text(
                    item.taskName ?? '',
                    style: TextStyleTheme.current.bodyText2Heavy.copyWith(
                      color: kNeutral900,
                    ),
                  ),
                  SizedBox(
                    height: 4.w,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: kNeutral400,
                        size: 11.w,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        item.dueDate ?? '',
                        style: TextStyleTheme.current.bodyText4Light.copyWith(
                          color: kNeutral400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                _showBottomSheet(context: context, item: item);
              },
              icon: const Icon(
                Icons.more_vert,
              ),
              color: kNeutral600,
            )
          ],
        ),
      ),
    );
  }

  void _showTodoDetailBottomSheet(
      {required BuildContext context, required Task item}) {
    final viewModel = context.read<HomeViewModel>();
    final headerHeight = 65.w;

    showSlidingBottomSheet(
      context,
      builder: (ctx) {
        return SlidingSheetDialog(
          color: kNeutral0,
          minHeight: 36.w,
          dismissOnBackdropTap: true,
          isBackdropInteractable: true,
          cornerRadius: 20.r,
          avoidStatusBar: true,
          extendBody: true,
          cornerRadiusOnFullscreen: 0,
          duration: const Duration(milliseconds: 200),
          snapSpec: const SnapSpec(
            snap: true,
            initialSnap: 0.35,
            snappings: [
              0.35,
            ],
          ),
          scrollSpec: const ScrollSpec(
            showScrollbar: false,
            physics: BouncingScrollPhysics(),
          ),
          headerBuilder: (ctx, state) {
            return Material(
              color: kNeutral0,
              child: Container(
                height: headerHeight,
                width: 1.sw,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 12.w),
                    Container(
                      height: 4.w,
                      width: 40.w,
                      decoration: BoxDecoration(
                          color: kNeutral500,
                          borderRadius: BorderRadius.all(Radius.circular(4.w))),
                    ),
                    SizedBox(height: 10.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.close,
                            size: 24.w,
                            color: kNeutral300,
                          ),
                        ),
                        Text(
                          'Task',
                          style: TextStyleTheme.current.bodyText1Heavy.copyWith(
                            color: kNeutral600,
                            height: 1.75,
                          ),
                        ),
                        SizedBox(width: 24.w),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          builder: (ctx, state) {
            return ListenableProvider.value(
              value: viewModel,
              child: Material(
                color: kNeutral0,
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 16.w, right: 16.w, top: headerHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title:',
                          style: TextStyleTheme.current.bodyText2Heavy,
                        ),
                        Text(
                          item.taskName ?? '',
                          style: TextStyleTheme.current.bodyText3Light,
                        ),
                        SizedBox(
                          height: 12.w,
                        ),
                        Text(
                          'Description:',
                          style: TextStyleTheme.current.bodyText2Heavy,
                        ),
                        Text(
                          item.description ?? '',
                          style: TextStyleTheme.current.bodyText3Light,
                        ),
                        SizedBox(
                          height: 12.w,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: 18.w,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              item.dueDate ?? '',
                              style: TextStyleTheme.current.bodyText3Light,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.w,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 28.w,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return kError;
                                    },
                                  ),
                                  textStyle: MaterialStateProperty.resolveWith<
                                      TextStyle>(
                                    (states) =>
                                        TextStyleTheme.current.bodyText2Heavy,
                                  ),
                                  shape: MaterialStateProperty.resolveWith<
                                      OutlinedBorder>(
                                    (Set<MaterialState> states) {
                                      return RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: kError,
                                          width: 1.w,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      );
                                    },
                                  ),
                                ),
                                onPressed: () async {
                                  context
                                      .read<HomeViewModel>()
                                      .deleteTask(item.id ?? '');

                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete_forever,
                                      color: kNeutral0,
                                      size: 16.w,
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Text(
                                      'Delete',
                                      style: TextStyleTheme
                                          .current.bodyText3Heavy
                                          .copyWith(
                                        color: kNeutral0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            SizedBox(
                              height: 28.w,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return kSuccess;
                                    },
                                  ),
                                  textStyle: MaterialStateProperty.resolveWith<
                                      TextStyle>(
                                    (states) =>
                                        TextStyleTheme.current.bodyText2Heavy,
                                  ),
                                  shape: MaterialStateProperty.resolveWith<
                                      OutlinedBorder>(
                                    (Set<MaterialState> states) {
                                      return RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: kSuccess,
                                          width: 1.w,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      );
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    RouteList.createTodo,
                                    arguments: item,
                                  ).whenComplete(() {
                                    context.read<HomeViewModel>().fetchTask();
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit_note_sharp,
                                      color: kNeutral0,
                                      size: 16.w,
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Text(
                                      'Update',
                                      style: TextStyleTheme
                                          .current.bodyText3Heavy
                                          .copyWith(
                                        color: kNeutral0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showBottomSheet({required BuildContext context, required Task item}) {
    final viewModel = context.read<HomeViewModel>();

    final headerHeight = 65.w;

    showSlidingBottomSheet(
      context,
      builder: (_) {
        return SlidingSheetDialog(
          color: kNeutral0,
          minHeight: 36.w,
          dismissOnBackdropTap: true,
          isBackdropInteractable: true,
          cornerRadius: 20.r,
          avoidStatusBar: true,
          extendBody: true,
          cornerRadiusOnFullscreen: 0,
          duration: const Duration(milliseconds: 200),
          snapSpec: const SnapSpec(
            snap: true,
            initialSnap: 0.30,
            snappings: [
              0.30,
            ],
          ),
          scrollSpec: const ScrollSpec(
            showScrollbar: false,
            physics: BouncingScrollPhysics(),
          ),
          headerBuilder: (_, state) {
            return Material(
              color: kNeutral0,
              child: Container(
                height: headerHeight,
                width: 1.sw,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 12.w),
                    Container(
                      height: 4.w,
                      width: 40.w,
                      decoration: BoxDecoration(
                          color: kNeutral500,
                          borderRadius: BorderRadius.all(Radius.circular(4.w))),
                    ),
                    SizedBox(height: 10.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.close,
                            size: 24.w,
                            color: kNeutral300,
                          ),
                        ),
                        Text(
                          'Select Status',
                          style: TextStyleTheme.current.bodyText1Heavy.copyWith(
                            color: kNeutral600,
                            height: 1.75,
                          ),
                        ),
                        SizedBox(width: 24.w),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          builder: (_, state) {
            final statusId = item.status?.id;
            return Material(
              color: kNeutral0,
              child: SafeArea(
                top: false,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: headerHeight,
                  ),
                  itemCount: viewModel.statusList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) => Builder(builder: (_) {
                    final data = viewModel.statusList[index];
                    return InkWell(
                      onTap: () {
                        _onChange(
                          context: context,
                          id: item.id ?? '',
                          statusId: data.id ?? '',
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            data.status?.toUpperCase() ?? '',
                            style:
                                TextStyleTheme.current.bodyText1Light.copyWith(
                              color: kNeutral800,
                            ),
                          ),
                          const Spacer(),
                          if (statusId == data.id) ...[
                            const Icon(
                              Icons.check,
                              color: kPrimary,
                            )
                          ]
                        ],
                      ),
                    );
                  }),
                  separatorBuilder: (context, index) => const Divider(
                    color: kNeutral100,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onChange({
    required BuildContext context,
    required String id,
    required String statusId,
  }) async {
    final data = await context.read<HomeViewModel>().updateStatus(id, statusId);

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
}
