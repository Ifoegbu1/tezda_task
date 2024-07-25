import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:tezda_task/presentation/home/controller/home_ctr.dart';
import 'package:tezda_task/presentation/home/model/product_model.dart';

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({
    super.key,
    required this.homeCtr,
    required this.product,
  });

  final HomeController homeCtr;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: 20,
      isLiked: homeCtr.isFavourite(product.id),
      onTap: (isLiked) async {
        homeCtr.addToOrRemoveFav(
          product,
        );
        return !isLiked;
      },
      likeBuilder: (isLiked) {
        return Icon(
          isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
          color: isLiked ? Colors.red : null,
        );
      },
    );
  }
}
