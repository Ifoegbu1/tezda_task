import 'package:flutter/material.dart';
import 'package:tezda_task/theme/app_style.dart';
import 'package:tezda_task/utils/app_colors.dart';

class TextSeeMore extends StatefulWidget {
  final String text;

  const TextSeeMore({
    super.key,
    required this.text,
  });

  @override
  State<TextSeeMore> createState() => _TextSeeMoreState();
}

class _TextSeeMoreState extends State<TextSeeMore> {
  int? maxLines = 3;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: widget.text,
            style: AppStyle.txtQuicksand.copyWith(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          maxLines: 3, // Set the maximum number of lines you want to check
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(maxWidth: constraints.maxWidth);

        if (textPainter.didExceedMaxLines) {
          // Text exceeds three lines
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            // clipBehavior: Clip.hardEdge,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.text,
                // focusNode: widget.focus,
                maxLines: maxLines,
                // minLines: 1,
                style: AppStyle.txtQuicksand.copyWith(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                // scrollPhysics: const NeverScrollableScrollPhysics(),
              ),
              // TextButton(
              //   child: Text(maxLines == 5 ? 'show more' : 'show less'),
              // onPressed: () {
              //   setState(() {
              //     if (maxLines == 5) {
              //       maxLines = null;
              //     } else {
              //       maxLines = 5;
              //     }
              //   });
              // },
              // ),

              InkWell(
                borderRadius: BorderRadius.circular(10),
                highlightColor: AppColors.lightGrey,
                onTap: () {
                  setState(() {
                    if (maxLines == 3) {
                      maxLines = null;
                    } else {
                      maxLines = 3;
                    }
                  });
                },
                child: Text(
                  maxLines == 3 ? 'show more' : 'show less',
                  style: TextStyle(
                      color: maxLines != 3 ? AppColors.lightBlue : Colors.teal,
                      fontSize: 12,),
                ),
              ),
            ],
          );
        } else {
          // Text does not exceed five lines
          return Text(
            widget.text,
            // focusNode: widget.focus,
            style: AppStyle.txtQuicksand.copyWith(
              // color: AppColors.neutral4,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
            // scrollPhysics: const NeverScrollableScrollPhysics(),
          );
        }
      },
    );
  }
}
