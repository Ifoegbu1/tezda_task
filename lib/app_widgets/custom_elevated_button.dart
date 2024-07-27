import 'package:flutter/material.dart';
import 'package:tezda_task/utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry margin;
  final Size minimumSize;
  final Size? maximumSize;
  final Size? fixedSize;
  final VisualDensity? visualDensity;
  final Color? pressedColor;
  final OutlinedBorder? shape;
  final AlignmentGeometry? alignment;
  final Color? foregroundColor;
  final double? elevation;
  const CustomElevatedButton({
    super.key,
    this.onPressed,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.margin = const EdgeInsets.all(0),
    this.minimumSize = const Size(30, 30), // Default minimum size
    this.maximumSize,
    this.fixedSize,
    this.visualDensity,
    this.pressedColor,
    this.shape,
    this.alignment,
    this.foregroundColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    Color? defaultBgClr = AppColors.lightBlue;
    return Padding(
      padding: margin,
      child:
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     elevation: elevation,
          //     foregroundColor: foregroundColor,
          //     alignment: alignment,
          //     surfaceTintColor: backgroundColor,
          //     disabledBackgroundColor: backgroundColor,
          //     enableFeedback: true,
          //     backgroundColor: backgroundColor,
          //     shape: shape,
          //     visualDensity: visualDensity,
          //     minimumSize: minimumSize,
          //     fixedSize: fixedSize,
          //     maximumSize: maximumSize,
          //     padding: padding,
          //   ),
          //   onPressed: onPressed,
          //   child: child,
          // ),
          ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(elevation),
          foregroundColor: WidgetStatePropertyAll(foregroundColor),
          alignment: alignment,
          surfaceTintColor: WidgetStatePropertyAll(
            backgroundColor ?? defaultBgClr,
          ),
          // disabledBackgroundColor: backgroundColor,
          enableFeedback: true,
          backgroundColor: WidgetStatePropertyAll(
            backgroundColor ?? defaultBgClr,
          ),
          shape: WidgetStatePropertyAll(shape),
          visualDensity: visualDensity,

          minimumSize: WidgetStatePropertyAll(minimumSize),
          fixedSize: WidgetStatePropertyAll(fixedSize),
          maximumSize: WidgetStatePropertyAll(maximumSize),
          padding: WidgetStatePropertyAll(padding),
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                if (pressedColor != null) {
                  return pressedColor!
                      .withOpacity(0.2); // Highlight color when pressed
                }
                if (states.contains(WidgetState.disabled)) {
                  return backgroundColor ?? defaultBgClr;
                }
              }
              return null; // Use default color otherwise
            },
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
