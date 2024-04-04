import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_application/common/style/text_style.dart';
import 'package:todo_application/common/style/theme_app_style.dart';
import 'package:todo_application/core/router/route_list.dart';
import 'package:todo_application/core/router/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// init
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await ScreenUtil.ensureScreenSize();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 640),
        builder: (_, child) {
          TextStyleTheme.init();
          return LayoutBuilder(builder: (context, constraints) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Pandawa",
              theme: themeApp,
              initialRoute: RouteList.main,
              routes: Routes().allRoutes,
              onGenerateRoute: Routes.getRouteGenerate,
              navigatorKey: navigatorKey,
              builder: (context, child) {
                return child ?? const SizedBox.shrink();
              },
            );
          });
        });
  }
}
