import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tezda_task/app_widgets/custom_container_tab.dart';
import 'package:tezda_task/app_widgets/custom_image_view.dart';
import 'package:tezda_task/presentation/home/controller/home_ctr.dart';
import 'package:tezda_task/presentation/home/widgets/products_grid.dart';
import 'package:tezda_task/presentation/user/controller/user_controller.dart';
import 'package:tezda_task/presentation/user/screens/profile_screen.dart';
import 'package:tezda_task/theme/app_style.dart';
import 'package:tezda_task/utils/app_colors.dart';
import 'package:tezda_task/utils/app_functions.dart';

class Home extends StatefulWidget {
  final bool isFav;
  const Home({
    super.key,
    required this.isFav,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ContainedTabBarViewState> tabKey = GlobalKey();

  final homeCtr = Get.find<HomeController>();

  final userCtr = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            toolbarHeight: 70.0.dynH,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                  onTap: () => Get.to(
                    () => ProfileScreen(
                      isFromAcc: false,
                      userCtr: userCtr,
                    ),
                  ),
                  child: Hero(
                    tag: 'profile-pic',
                    child: CircleAvatar(
                      child: CustomImageView(
                        isProfile: true,
                        fit: BoxFit.cover,
                        url: userCtr.user.photoURL,
                        height: 100.0.dynH,
                        width: 100.0.dynW,
                        radius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Explore',
                  style: AppStyle.txtQuicksand.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  ),
                ),
                Text(
                  widget.isFav ? 'Your Favourites' : 'Tezda Products',
                  style: AppStyle.txtQuicksand.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      decorationColor: AppColors.lightBlue,
                      decorationStyle: TextDecorationStyle.solid,
                      decoration: TextDecoration.underline,),
                ),
              ],
            ),
          ),
          body: homeCtr.isLoaded
              ? homeCtr.getProductsList(widget.isFav).isNotEmpty
                  ? Builder(builder: (context) {
                      if (widget.isFav) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: ProductsGrid(isFav: widget.isFav),
                        );
                      }

                      return Theme(
                        data: Theme.of(context).copyWith(
                          tabBarTheme: const TabBarTheme(
                              dividerColor: Colors.transparent,),
                        ),
                        child: CustomContainedTabBarView(
                          callOnChangeWhileIndexIsChanging: true,
                          initialIndex: widget.isFav
                              ? homeCtr.selectedFavTab
                              : homeCtr.selectedHomeTab,
                          key: tabKey,
                          tabBarViewProperties: const TabBarViewProperties(
                              physics: NeverScrollableScrollPhysics(),),
                          tabBarProperties: TabBarProperties(
                              position: TabBarPosition.top,
                              indicatorSize: TabBarIndicatorSize.label,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              margin: const EdgeInsets.all(10),
                              labelStyle: AppStyle.txtQuicksand.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w600,),
                              labelColor: Colors.white,
                              indicator: ContainerTabIndicator(
                                height: 22.0.dynH,
                                width: 83.0.dynW,
                                radius: BorderRadius.circular(71),
                                color: AppColors.lightBlue,
                              ),
                              unselectedLabelColor: AppColors.tabTextClr(),),
                          tabs: List.generate(
                              homeCtr.getCategories(widget.isFav).length,
                              (index) => Text(getFirstWord(
                                  homeCtr.getCategories(widget.isFav)[index],),),),
                          views: List.generate(
                              homeCtr.getCategories(widget.isFav).length,
                              (index) => ProductsGrid(
                                    isFav: widget.isFav,
                                  ),),
                          onChange: (index) {
                            tezdaLog('ONCHANGE ${homeCtr.favCategories}');
                            tezdaLog('ONCHANGE${homeCtr.selectedFavTab}');
                            if (widget.isFav) {
                              homeCtr.selectedFavTab = index;
                            } else {
                              homeCtr.selectedHomeTab = index;
                            }

                            homeCtr.filterProducts(widget.isFav);
                          },
                        ),
                      );
                    },)
                  : Center(
                      child: Text(
                        widget.isFav
                            ? 'You have no favourites right now'
                            : 'No products available at the moment',
                        style: AppStyle.txtQuicksand,
                      ),
                    )
              : Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballPulseSync,
                      colors: [
                        Colors.black,
                        AppColors.lightGrey,
                        AppColors.lightBlue,
                      ],
                      strokeWidth: 2,
                      backgroundColor: Colors.transparent,
                      pathBackgroundColor: Colors.transparent,
                    ),
                  ),
                ),);
    },);
  }
}
