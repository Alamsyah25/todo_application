import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../style/text_style.dart';

class ValidatedController extends ValueNotifier<bool> {
  ValidatedController(bool value) : super(value);

  bool get isValid => value;
}

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.floatingLabel,
      this.maxLines = 1,
      this.maxLength,
      this.textEditingController,
      this.keyboardType,
      this.validator,
      this.focusNode,
      this.onTap,
      this.readOnly,
      this.validateController});
  final String floatingLabel;
  final int maxLines;
  final int? maxLength;
  final TextEditingController? textEditingController;
  final ValidatedController? validateController;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool? readOnly;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController? textController;

  @override
  void initState() {
    textController = widget.textEditingController;
    textController ??= TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.floatingLabel,
          style: TextStyleTheme.current.bodyText3Light
              .copyWith(color: kNeutral1000),
        ),
        SizedBox(
          height: 4.w,
        ),
        TextFormField(
          controller: widget.textEditingController,
          validator: widget.validator,
          scrollPadding: EdgeInsets.only(bottom: 100.w),
          onTap: widget.onTap,
          style: TextStyleTheme.current.bodyText2Light.copyWith(
            height: 1,
            color: kNeutral1000,
          ),
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          readOnly: widget.readOnly ?? false,
          decoration: const InputDecoration(
            fillColor: kNeutral900,
            focusColor: kNeutral50,
          ),
        ),
      ],
    );
  }
}
