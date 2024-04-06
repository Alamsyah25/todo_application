import 'package:flutter/material.dart';
import 'package:todo_application/common/constants/colors.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({Key? key, this.color = kPrimary}) : super(key: key);
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
