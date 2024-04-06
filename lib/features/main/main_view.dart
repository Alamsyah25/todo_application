import 'package:flutter/material.dart';

import '../home/home_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});
  static final mainScaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'mainScaffoldKey');

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: MainView.mainScaffoldKey,
        backgroundColor: Colors.white,
        body: const HomeView());
  }
}
