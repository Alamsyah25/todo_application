import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/core/base/mvvm.dart';
import 'package:todo_application/features/home/view_model/home_view_model.dart';
import 'package:todo_application/features/home/widget/task_list_section.dart';
import 'package:todo_application/features/home/widget/task_overview_section.dart';

import '../../common/constants/colors.dart';
import '../../common/style/text_style.dart';
import '../../core/router/route_list.dart';
import 'repository/home_repository.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  PreferredSizeWidget appBar({required BuildContext context}) {
    return AppBar(
      title: const Text('Home'),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteList.createTodo).whenComplete(() {
              context.read<HomeViewModel>().fetchTask();
            });
          },
          icon: const Icon(
            Icons.playlist_add,
            color: kNeutral0,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MvvmBuilder<HomeViewModel>(
      viewModel: HomeViewModel(homeRepository: HomeRepository()),
      view: (context) {
        return Scaffold(
          backgroundColor: kNeutral0,
          appBar: appBar(context: context),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back! ready for your next task?',
                  style: TextStyleTheme.current.bodyText3Light
                      .copyWith(color: kNeutral500),
                ),
                SizedBox(
                  height: 12.w,
                ),
                const TaskOverviewSection(),
                SizedBox(
                  height: 12.w,
                ),
                const TaskListSection()
              ],
            ),
          ),
        );
      },
      key: const ValueKey('home-view'),
    );
  }
}
