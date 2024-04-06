import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'common/constants/string.dart';
import 'common/style/text_style.dart';
import 'common/style/theme_app_style.dart';
import 'core/router/route_list.dart';
import 'core/router/routes.dart';
import 'core/utils/logger.dart';

void main() async {
  await runZonedGuarded(() async {
    /// Init
    final WidgetsBinding widgetsBinding =
        WidgetsFlutterBinding.ensureInitialized();

    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    await ScreenUtil.ensureScreenSize();

    await Supabase.initialize(
      url: Constants.supabaseUrl,
      anonKey: Constants.supabaseAnnonKey,
    );

    runApp(const TodoApp());
  }, (error, stack) {
    if (kDebugMode) {
      logger.w('run zoned guarded', error: error, stackTrace: stack);
    }
  });
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (_, child) {
        TextStyleTheme.init();
        return LayoutBuilder(
          builder: (context, constraints) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Toolis',
              theme: themeApp,
              initialRoute: RouteList.main,
              routes: Routes().allRoutes,
              onGenerateRoute: Routes.getRouteGenerate,
              navigatorKey: navigatorKey,
              builder: (context, child) {
                return child ?? const SizedBox.shrink();
              },
            );
          },
        );
      },
    );
  }
}
