import 'package:flutter/material.dart';
import 'package:todo_application/common/constants/colors.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: kPrimary1,
      ),
    );
  }
}
