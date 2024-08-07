import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key, this.height, this.width});

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
