import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:tezda_task/app_widgets/custom_image_view.dart';
import 'package:tezda_task/presentation/home/controller/home_ctr.dart';
import 'package:tezda_task/presentation/home/model/product_model.dart';
import 'package:tezda_task/presentation/home/widgets/favourite_button.dart';
import 'package:tezda_task/presentation/product_detail/product_detail.dart';
import 'package:tezda_task/theme/app_style.dart';
import 'package:tezda_task/utils/app_colors.dart';
import 'package:tezda_task/utils/app_functions.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({
    super.key,
    required this.product,
    required this.homeCtr,
  });
  final ProductModel product;
  final HomeController homeCtr;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.all(0),
        child: Container(
          // height: 270.0.dynH,
          width: 150.0.dynW,
          // width: 100.0.dynW,
          // padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.homeItemBgClr()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Hero(
                  tag: product.id,
                  child: CustomImageView(
                      onTap: () => Get.to(
                          transition: Transition.fadeIn,
                          () => ProductDetail(
                                product: product,
                                homeCtr: homeCtr,
                              )),
                      // padding: const EdgeInsets.only(top: 10),
                      fit: BoxFit.cover,
                      showForeGDeco: true,
                      border:
                          Border.all(color: AppColors.lightGrey.withAlpha(210)),
                      radius: BorderRadius.circular(8),
                      height: 150.0.dynH,
                      width: 200.0.dynW,
                      url: product.image),
                ),
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5, right: 10),
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 110.0.dynW,
                            child: Marquee(
                              animationDuration: 10.seconds,
                              child: Text(
                                product.title,
                                style: AppStyle.txtQuicksand,
                              ),
                            ),
                          ),
                          const Gap(3),
                          Text(
                            '\$${product.price}',
                            style: AppStyle.txtQuicksand
                                .copyWith(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child:
                            FavouriteButton(homeCtr: homeCtr, product: product),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
