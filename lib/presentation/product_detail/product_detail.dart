import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:tezda_task/app_widgets/custom_elevated_button.dart';
import 'package:tezda_task/app_widgets/custom_image_view.dart';
import 'package:tezda_task/app_widgets/text_see_more.dart';
import 'package:tezda_task/presentation/home/controller/home_ctr.dart';
import 'package:tezda_task/presentation/home/model/product_model.dart';
import 'package:tezda_task/presentation/home/widgets/favourite_button.dart';
import 'package:tezda_task/theme/app_style.dart';
import 'package:tezda_task/utils/app_colors.dart';
import 'package:tezda_task/utils/app_functions.dart';

class ProductDetail extends StatefulWidget {
  final HomeController homeCtr;
  final ProductModel product;
  const ProductDetail({
    super.key,
    required this.homeCtr,
    required this.product,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int? selectedClrIndex;
  int? selectedSizeIndex;
  static const List<Color> colors = [
    Colors.green,
    Colors.brown,
    Colors.grey,
    Colors.blue,
  ];
  static const List<String> sizes = [
    'S',
    'M',
    'L',
    'XL',
    'XXL',
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          // backgroundColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: Text(
            'Product Details',
            style: AppStyle.txtQuicksand,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8,
            // bottom: MediaQuery.of(context).size.height * 0.095,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: widget.product.id,
                  child: CustomImageView(
                    fit: BoxFit.contain,
                    // showForeGDeco: true,
                    height: 400.0.dynH,
                    padding: const EdgeInsets.all(8),
                    border: Border.all(color: AppColors.lightGrey),
                    alignment: Alignment.center,
                    url: widget.product.image,
                    radius: BorderRadius.circular(8),
                    width: width * 0.8,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 230.0.dynW,
                      child: Marquee(
                        animationDuration: 20.seconds,
                        child: Text(
                          widget.product.title,
                          style: AppStyle.txtQuicksand
                              .copyWith(fontSize: 24.0.dynFont),
                        ),
                      ),
                    ),
                    const Gap(30),
                    Text(
                      '\$${widget.product.price}',
                      style: AppStyle.txtQuicksand.copyWith(
                          fontSize: 24.0.dynFont, color: AppColors.lightBlue),
                    ),
                  ],
                ),
                const Gap(2),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                    const Gap(2),
                    Text(
                      '${widget.product.rating.rate} (${widget.product.rating.count})  212 reviews',
                      style: AppStyle.txtQuicksand.copyWith(color: Colors.grey),
                    ),
                  ],
                ),

                TextSeeMore(text: widget.product.description),
                // Text(
                //   maxLines: 2,
                //   widget.product.description,
                //   style: AppStyle.txtQuicksand.copyWith(color: Colors.grey),
                // ),
                const Gap(10),
                Text(
                  'Select Color',
                  style: AppStyle.txtQuicksand,
                ),
                const Gap(5),
                Row(
                  children: List.generate(
                      colors.length,
                      (index) => productClrs(colors[index], () {
                            setState(() {
                              selectedClrIndex = index;
                            });
                          }, index)),
                ),
                const Gap(10),
                Text(
                  'Select Size',
                  style: AppStyle.txtQuicksand,
                ),
                Row(
                  children: List.generate(
                      sizes.length,
                      (index) => productSizes(sizes[index], () {
                            setState(() {
                              selectedSizeIndex = index;
                            });
                          }, index)),
                ),

                Gap(
                  MediaQuery.of(context).size.height * 0.1,
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: CustomFloatingBtn(widget: widget));
  }

  Widget productClrs(Color color, Function() onTap, int index) {
    return Padding(
      padding: EdgeInsets.only(left: index != 0 ? 5 : 0),
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
            radius: 10,
            backgroundColor: color,
            child: selectedClrIndex == index
                ? const FittedBox(
                    child: Icon(
                    Icons.check,
                    color: Colors.black,
                    size: 15,
                  ))
                : null),
      ),
    );
  }

  Widget productSizes(String productSize, Function() onTap, int index) {
    return CustomElevatedButton(
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
          side: const BorderSide(
            color: Colors.grey,
          ),
        ),
        onPressed: onTap,
        backgroundColor: selectedSizeIndex == index
            ? AppColors.lightBlue
            : AppColors.sizeBgClr(),
        child: FittedBox(
          child: Text(
            productSize,
            style:
                AppStyle.txtQuicksand.copyWith(color: AppColors.sizeTxtClr()),
          ),
        ));
    // GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //       // height: 40,
    //       // width: 40,
    //       margin: EdgeInsets.only(left: index != 0 ? 5 : 0),
    //       padding: const EdgeInsets.symmetric(
    //         horizontal: 8,
    //       ),
    //       decoration: BoxDecoration(
    //           shape: BoxShape.rectangle,
    //           borderRadius: BorderRadius.circular(15),
    //           // color: selectedSizeIndex == index ? AppColors.lightBlue : null,
    //           border: Border.all(color: Colors.black87)),
    //       child: FittedBox(
    //         child: Text(
    //           productSize,
    //           style: AppStyle.txtQuicksand,
    //         ),
    //       )),
    // )
  }
}

class CustomFloatingBtn extends StatelessWidget {
  const CustomFloatingBtn({
    super.key,
    required this.widget,
  });

  final ProductDetail widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomElevatedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(horizontal: 68, vertical: 10),
            onPressed: () {},
            child: Text(
              'Add To Cart',
              style: AppStyle.txtQuicksand
                  .copyWith(color: Colors.white, fontSize: 20),
            ),
          ),
          const Gap(20),
          CustomElevatedButton(
            backgroundColor: AppColors.lightGrey,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            onPressed: () {},
            child: FittedBox(
              child: FavouriteButton(
                  homeCtr: widget.homeCtr, product: widget.product),
            ),
          ),
          const Gap(2),
        ],
      ),
    );
  }
}
