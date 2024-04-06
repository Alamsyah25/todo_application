import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'base_view_model.dart';

class MvvmBuilder<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext) view;
  final T viewModel;
  final bool disposeViewModel;
  final bool initOnce;

  const MvvmBuilder(
      {required this.view,
      required this.viewModel,
      this.disposeViewModel = true,
      this.initOnce = false,
      required Key key})
      : super(key: key);

  @override
  _MvvmBuilder<T> createState() => _MvvmBuilder<T>();
}

class _MvvmBuilder<T extends ChangeNotifier> extends State<MvvmBuilder<T>>
    with WidgetsBindingObserver {
  late T _vm;
  bool _initialized = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('###state: $state, ${T.toString()}');
    }

    /// use it when needed,
    /// ex. to manipulate data when lifecycle changes or
    /// save to local storage when user close the apps.
    switch (state) {
      case AppLifecycleState.resumed:
        (_vm as BaseViewModel).onResume();
        break;
      case AppLifecycleState.inactive:
        (_vm as BaseViewModel).onInactive();
        break;
      case AppLifecycleState.paused:
        (_vm as BaseViewModel).onPause();
        break;
      case AppLifecycleState.detached:
        (_vm as BaseViewModel).onDetach();
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _vm = widget.viewModel;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (identical(_vm, widget.viewModel)) {
      _vm = widget.viewModel;
    }

    (_vm as BaseViewModel).context = context;

    if (widget.initOnce && !_initialized) {
      (_vm as BaseViewModel).init();
      _initialized = true;
    } else if (!widget.initOnce) {
      (_vm as BaseViewModel).init();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    (_vm as BaseViewModel).onBuild();

    if (!widget.disposeViewModel) {
      return ChangeNotifierProvider.value(
          value: _vm,
          child: Builder(builder: (context) => widget.view(context)));
    }
    return ChangeNotifierProvider(
      create: (context) => _vm,
      child: Builder(builder: (context) => widget.view(context)),
    );
  }
}
