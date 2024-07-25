import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tezda_task/theme/app_style.dart';
import 'package:tezda_task/utils/app_colors.dart';
import 'package:tezda_task/utils/app_functions.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.borderSide,
    this.enabledBorderSide,
    this.onTapOutside,
    this.color,
    this.fillColor,
    this.radius,
    this.contentPadding,
    this.hintStyle,
    this.isFilled,
    this.padding,
    this.autofillHints,
    this.isHintFloating,
    this.onFieldSubmitted,
    this.fontStyle,
    this.readOnly = false,
    this.counterText,
    this.alignment,
    this.width,
    this.onTap,
    this.height,
    this.inputFormatters,
    this.margin,
    this.controller,
    this.focusNode,
    this.isObscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.maxLength,
    this.hintText,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.validator,
    this.onChanged,
  });
  final BorderSide? borderSide;
  final BorderSide? enabledBorderSide;
  final Function(PointerDownEvent)? onTapOutside;
  final Color? color;
  final Color? fillColor;
  final double? radius;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle;
  final bool? isFilled;
  final EdgeInsetsGeometry? padding;

  final Iterable<String>? autofillHints;
  final bool? isHintFloating;
  final Function(String)? onFieldSubmitted;

  final TextStyle? fontStyle;
  final bool? readOnly;
  final Widget? counterText;
  final Alignment? alignment;

  final double? width;
  final Function()? onTap;
  final double? height;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? isObscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final int? maxLength;
  final String? hintText;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildTextFormFieldWidget(),
          )
        : _buildTextFormFieldWidget();
  }

  _buildTextFormFieldWidget() {
    return Container(
      constraints: BoxConstraints(
        minHeight: height ?? 0,
      ),
      // height: getVerticalSize(height ?? 0),
      width: width ?? 0,
      margin: margin,
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        onTap: onTap,
        maxLength: maxLength,
        onTapOutside: onTapOutside,
        autofillHints: autofillHints,
        onChanged: onChanged,
        readOnly: readOnly!,
        controller: controller,
        focusNode: focusNode,
        style: hintStyle ?? _setFontStyle(),
        obscureText: isObscureText!,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        maxLines: maxLines ?? 1,
        decoration: _buildDecoration(),
        validator: validator,
        inputFormatters: inputFormatters,
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      counter: counterText,
      // counterStyle: theme.materialData.textTheme.bodyMedium.,
      // constraints: const BoxConstraints(minHeight: 90),
      hintText: isHintFloating != null ? '' : hintText ?? "",
      labelText: isHintFloating != null ? hintText : null,
      floatingLabelStyle: isHintFloating != null
          ? AppStyle.txtQuicksand.copyWith(color: Colors.grey)
          : null,
      hintStyle: hintStyle ??
          AppStyle.txtQuicksand.copyWith(
            color: AppColors.lightGrey,
            fontSize: 12.0.dynFont,
          ),
      // errorStyle: AppStyle.txtInterRegular16.copyWith(color: Colors.redAccent),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: OutlineInputBorder(
        borderRadius: _setOutlineBorderRadius(),
        borderSide: enabledBorderSide ?? BorderSide.none,
      ),
      disabledBorder: _setBorderStyle(),
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      isCollapsed: false,

      suffixIconConstraints: suffixConstraints,
      filled: isFilled ?? false,
      isDense: true,
      fillColor: fillColor,
      contentPadding: contentPadding ?? _setPadding(),
    );
  }

  _setFontStyle() {
    return fontStyle;
  }

  // _setFillColor() {
  //   return color;
  // }

  _setOutlineBorderRadius() {
    return BorderRadius.circular(radius ?? 0);
  }

  _setBorderStyle() {
    return OutlineInputBorder(
      borderRadius: _setOutlineBorderRadius(),
      borderSide: borderSide ?? BorderSide.none,
    );
  }

  // _setFilled() {
  //   return false;
  // }

  _setPadding() {
    return padding;
  }
}
