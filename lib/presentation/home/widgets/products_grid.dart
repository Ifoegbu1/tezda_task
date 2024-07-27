import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:tezda_task/presentation/home/controller/home_ctr.dart';
import 'package:tezda_task/presentation/home/model/product_model.dart';
import 'package:tezda_task/presentation/home/widgets/product_item.dart';
import 'package:tezda_task/theme/app_style.dart';

class ProductsGrid extends StatelessWidget {
  final bool isFav;
  ProductsGrid({
    super.key,
    required this.isFav,
  });

  final homeCtr = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
      child: homeCtr.getProductsList(isFav).isNotEmpty
          ? StaggeredGridView.countBuilder(
              itemCount: homeCtr.getProductsList(isFav).length,
              shrinkWrap: true,
              primary: false,
              crossAxisCount: 4,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              itemBuilder: (context, index) {
                ProductModel product = homeCtr.getProductsList(isFav)[index];
                return ProductItem(
                  product: product,
                  homeCtr: homeCtr,
                );
              },
              staggeredTileBuilder: (index) {
                return const StaggeredTile.fit(2);
              },
            )
          : Center(
              child: Text(
                'Nothing here for now',
                style: AppStyle.txtQuicksand,
              ),
            ),
    );
  }
}
