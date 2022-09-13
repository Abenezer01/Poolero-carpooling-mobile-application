import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? textController;
  final bool isPassword;
  final RxBool obscureTxt = true.obs;
  final TextInputType inputType;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;

  MyTextField({
    Key? key,
    this.labelText = '',
    this.textController,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isPassword
        ? Obx(() => TextFormField(
              controller: textController,
              obscureText: isPassword ? obscureTxt.value : false,
              onSaved: onSaved,
              validator: validator,
              style: TextStyle(
                color: AppTheme.naturalColor1,
                fontFamily: AppTheme.primaryFont,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              cursorColor: AppTheme.primaryColor,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: AppTheme.primaryColor)),
                labelText: labelText,
                labelStyle: TextStyle(
                  color: AppTheme.naturalColor4,
                  fontFamily: AppTheme.primaryFont,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                suffixIcon: isPassword
                    ? GestureDetector(
                        onTap: () => obscureTxt.value = !obscureTxt.value,
                        child: Icon(
                            obscureTxt.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppTheme.primaryColor),
                      )
                    : null,
              ),
            ))
        : TextFormField(
            controller: textController,
            onSaved: onSaved,
            validator: validator,
            readOnly: readOnly,
            onTap: onTap,
            keyboardType: inputType,
            obscureText: isPassword ? obscureTxt.value : false,
            style: TextStyle(
              color: AppTheme.naturalColor1,
              fontFamily: AppTheme.primaryFont,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            cursorColor: AppTheme.primaryColor,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 2, color: AppTheme.primaryColor),
              ),
              labelText: labelText,
              labelStyle: TextStyle(
                color: AppTheme.naturalColor4,
                fontFamily: AppTheme.primaryFont,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              suffixIcon: isPassword
                  ? GestureDetector(
                      onTap: () => obscureTxt.value = !obscureTxt.value,
                      child: Icon(
                          obscureTxt.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppTheme.primaryColor),
                    )
                  : null,
            ),
          );
  }
}
