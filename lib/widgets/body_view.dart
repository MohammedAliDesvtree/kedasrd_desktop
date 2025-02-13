import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/dummy_data.dart';

import 'package:kedasrd_windows/views/home_view.dart';
import 'package:kedasrd_windows/views/regular/regular_view.dart';
import 'package:kedasrd_windows/views/restaurant/bar_view.dart';
import 'package:kedasrd_windows/views/restaurant/orders_view.dart';
import 'package:kedasrd_windows/views/restaurant/shifts_view.dart';
import 'package:kedasrd_windows/views/restaurant/tables_view.dart';
import 'package:kedasrd_windows/views/restaurant/kitchen_view.dart';
import 'package:kedasrd_windows/views/restaurant/delivery_view.dart';
import 'package:kedasrd_windows/views/online_order/contact_view.dart';
import 'package:kedasrd_windows/views/restaurant/new_order_view.dart';
import 'package:kedasrd_windows/views/restaurant/restaurant_view.dart';
import 'package:kedasrd_windows/views/restaurant/active_order_view.dart';
import 'package:kedasrd_windows/views/super_market/super_market_view.dart';

import 'package:kedasrd_windows/widgets/custom_dropdowns.dart';
import 'package:kedasrd_windows/widgets/custom_searchbar.dart';
import 'package:kedasrd_windows/widgets/custom_icon_button.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';

class BodyView extends StatefulWidget {
  final RxString title;
  const BodyView({
    super.key,
    required this.title,
  });

  @override
  State<BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends State<BodyView> {
  final DrawerMenuController controller = Get.find<DrawerMenuController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height - 70.0,
      padding: const EdgeInsets.all(24.0),
      color: Themes.kLightColor,
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (controller.shouldShowBackButton())
                  CustomIconButton(
                    icon: Images.leftArrow,
                    paddingRight: 16.0,
                    onTap: () => controller.onBackTapped(),
                  ),
                Text(
                  widget.title.value,
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w700,
                    color: Themes.kDarkColor,
                  ),
                ),
                if (controller.shouldShowSearchBar())
                  const CustomSearchBar(hintText: "Search"),
                if (controller.shouldShowDropdowns())
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 16.0),
                      SizedBox(
                        width: size.width / 5.8,
                        child: CustomDropdowns(
                          listData: DummyData.priceListItems,
                          hintText: "Price List",
                          borderRadius: 100.0,
                          isOutlined: true,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      SizedBox(
                        width: size.width / 5.8,
                        child: CustomDropdowns(
                          listData: DummyData.categoryItems,
                          hintText: "Select Category",
                          borderRadius: 100.0,
                          isOutlined: true,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      SizedBox(
                        width: size.width / 5.8,
                        child: CustomDropdowns(
                          listData: DummyData.currencyItems,
                          hintText: "Select Currency",
                          borderRadius: 100.0,
                          isOutlined: true,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                    ],
                  ),
                if (controller.shouldShowFilter())
                  SizedBox(
                    width: size.width / 5.8,
                    child: CustomDropdowns(
                      listData: DummyData.filterItems,
                      hintText: "Select Filter",
                      borderRadius: 100.0,
                      isOutlined: true,
                    ),
                  ),
                if (controller.shouldShowCounts()) totalCountView(),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(child: _buildContent()),
          ],
        );
      }),
    );
  }

  Widget totalCountView() {
    return Container(
      height: 44.0,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Themes.kWhiteColor, borderRadius: BorderRadius.circular(8.0)),
      child: const Text(
        "Total Orders : 16",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Themes.kPrimaryColor,
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (controller.currentScreen.value) {
      case Screen.home:
        return const HomeView();
      case Screen.regular:
        return const RegularView(title: "Regular");
      case Screen.restaurant:
        return const RestaurantView();
      case Screen.fastfood:
        return const RegularView(title: "Fast Food");
      case Screen.superMarket:
        return const SuperMarketView();
      case Screen.onlineStore:
        return const RegularView(title: "Online Store");
      case Screen.newOrder:
        return const NewOrderView();
      case Screen.activeOrder:
        return const ActiveOrderView();
      case Screen.kitchen:
        return const KitchenView();
      case Screen.bar:
        return const BarView();
      case Screen.delivery:
        return const DeliveryView();
      case Screen.pickup:
        return const RegularView(title: "Fast Food");
      case Screen.tables:
        return const TablesView();
      case Screen.shifts:
        return const ShiftsView();
      case Screen.orders:
        return const OrdersView();
      case Screen.contact:
        return const ContactView();
      case Screen.help:
        return const SizedBox.shrink();
    }
  }
}
