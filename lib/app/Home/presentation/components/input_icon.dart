import 'package:carpooling_beta/app/core/components/my_text_field.dart';
import 'package:flutter/material.dart';

class InputIcon extends StatelessWidget {
  final TextEditingController? textController;
  final String icon;
  final String inputText;
  final TextInputType inputType;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;

  const InputIcon({
    Key? key,
    required this.icon,
    this.textController,
    this.inputText = '',
    this.inputType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(icon, width: 20, fit: BoxFit.fill),
        SizedBox(width: 10),
        Expanded(
          child: MyTextField(
              validator: validator,
              labelText: inputText,
              textController: textController,
              inputType: inputType,
              readOnly: readOnly,
              onTap: onTap),
        ),
      ],
    );
  }
}
