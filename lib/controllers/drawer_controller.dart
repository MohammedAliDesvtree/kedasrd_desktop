import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kedasrd_windows/utils/constants.dart';
import 'package:kedasrd_windows/utils/dummy_data.dart';
import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/widgets/custom_dropdowns.dart';
import 'package:kedasrd_windows/widgets/custom_text_input.dart';

enum Screen {
  // Dashboard
  home,
  // Main Menu Items
  regular,
  restaurant,
  fastfood,
  superMarket,
  onlineOrder,
  // Restaurant Items
  newOrder,
  activeOrder,
  kitchen,
  delivery,
  pickup,
  tables,
  // Inner Menu Items
  shifts,
  orders,
  help
}

class DrawerMenuController extends GetxController {
  final RxList<Screen> navigationHistory = <Screen>[Screen.home].obs;
  final Rx<Screen> currentScreen = Screen.home.obs;
  RxString screenTitle = "Home".obs;
  RxString currentParentMenu = "".obs;
  // Shifts View
  int totalItemCounts = 24;
  RxInt selectedIndex = (0).obs;

  @override
  void onInit() {
    super.onInit();
    navigationHistory.add(Screen.home);
  }

  @override
  void dispose() {
    super.dispose();
    navigationHistory.clear();
    currentScreen.value = Screen.home;
  }

  void navigateTo(Screen screen, String title) {
    if (currentScreen.value != screen) {
      navigationHistory.add(screen);
      currentScreen.value = screen;
      screenTitle.value = title;
    }
  }

  bool get canGoBack => navigationHistory.length > 1;

  void goBack() {
    if (canGoBack) {
      navigationHistory.removeLast();
      currentScreen.value = navigationHistory.last;
      updateScreenTitle();
    }
  }

  void onMenuMainItemTapped(String title) {
    navigateTo(Screen.home, "Home");
  }

  void onMenuInnerItemTapped(BuildContext context, Size size, String title) {
    // Set parent menu based on current context
    if (DummyData.dashboardList.any((item) => item["title"] == title)) {
      currentParentMenu.value = title;
    }

    switch (title) {
      case "Regular":
        navigateTo(Screen.regular, title);
        break;
      case "Restaurant":
        navigateTo(Screen.restaurant, title);
        break;
      case "Fast Food":
        navigateTo(Screen.fastfood, title);
        break;
      case "Super Market":
        navigateTo(Screen.superMarket, title);
        break;
      case "Online Order":
        // navigateTo(Screen.onlineOrder, title);
        Get.toNamed("online_order");
        break;
      // Inner Items
      case "Shifts":
        navigateTo(Screen.shifts, title);
        break;
      case "Orders":
        navigateTo(Screen.orders, title);
        break;
      case "New Order":
        navigateTo(Screen.newOrder, title);
        break;
      case "Items":
        onMenuTapped(context, size, title);
        break;
      case "Customers":
        onMenuTapped(context, size, title);
        break;
      case "Discard Order":
        onMenuTapped(context, size, title);
        break;
      case "Discount":
        onMenuTapped(context, size, title);
        break;
      case "Kitchen":
        navigateTo(Screen.kitchen, title);
        break;
      case "Active Order":
        navigateTo(Screen.activeOrder, title);
        break;
      case "Categories":
        navigateTo(Screen.fastfood, title);
        break;
      case "Table":
        navigateTo(Screen.tables, title);
        break;
    }
  }

  void onRestaurantItemTapped(String title) {
    switch (title) {
      case "New Order":
        navigateTo(Screen.newOrder, title);
        break;
      case "Active Order":
        navigateTo(Screen.activeOrder, title);
        break;
      case "Kitchen":
        navigateTo(Screen.kitchen, title);
        break;
    }
  }

  void onActiveOrderItemTapped(String title) {
    switch (title) {
      case "Dine In":
        navigateTo(Screen.tables, "Active Tables");
        break;
      case "Delivery":
        navigateTo(Screen.delivery, "Active Orders");
        break;
    }
  }

  void onNewOrderItemTapped(String title) {
    switch (title) {
      case "Dine In":
        navigateTo(Screen.tables, "Tables");
        break;
      case "Delivery":
        navigateTo(Screen.pickup, "Delivery");
        break;
      case "Pickup":
        navigateTo(Screen.pickup, title);
        break;
    }
  }

  void onBackTapped() {
    goBack();
  }

  void updateScreenTitle() {
    switch (currentScreen.value) {
      case Screen.home:
        screenTitle.value = "Home";
        break;
      case Screen.regular:
        screenTitle.value = "Regular";
        break;
      case Screen.restaurant:
        screenTitle.value = "Restaurant";
        break;
      case Screen.fastfood:
        screenTitle.value = "Fast Food";
        break;
      case Screen.superMarket:
        screenTitle.value = "Supermarket";
        break;
      case Screen.onlineOrder:
        screenTitle.value = "Online Order";
        break;
      case Screen.newOrder:
        screenTitle.value = "New Order";
        break;
      case Screen.activeOrder:
        screenTitle.value = "Active Order";
        break;
      case Screen.kitchen:
        screenTitle.value = "Kitchen";
        break;
      case Screen.delivery:
        screenTitle.value = "Delivery";
        break;
      case Screen.pickup:
        screenTitle.value = "Pickup";
        break;
      case Screen.tables:
        screenTitle.value = "Tables";
        break;
      case Screen.shifts:
        screenTitle.value = "Shifts";
        break;
      case Screen.orders:
        screenTitle.value = "Orders";
        break;
      case Screen.help:
        screenTitle.value = "help";
        break;
    }
  }

  Future<bool> onWillPop() async {
    if (canGoBack) {
      goBack();
      return false; // Prevent default back behavior
    }
    return true; // Allow app to close
  }

  void onLogoutTapped(BuildContext context) {
    Constants.openAlertDialog(
      context: context,
      title: "Logout",
      msg: "Are you sure you want to logout ?",
      toastMsg: "Logout Successfully!",
      positiveAction: () => onMenuMainItemTapped("Home"),
    );
  }

  bool isMainSelected(int index) {
    if (index == 0) {
      return currentScreen.value == Screen.home ||
          // Main Menu Items
          currentScreen.value == Screen.regular ||
          currentScreen.value == Screen.restaurant ||
          currentScreen.value == Screen.fastfood ||
          currentScreen.value == Screen.superMarket ||
          currentScreen.value == Screen.onlineOrder ||
          // Inner Items
          currentScreen.value == Screen.newOrder ||
          currentScreen.value == Screen.activeOrder ||
          currentScreen.value == Screen.kitchen ||
          currentScreen.value == Screen.delivery ||
          currentScreen.value == Screen.pickup ||
          currentScreen.value == Screen.tables ||
          // Inner Inner Items
          currentScreen.value == Screen.shifts ||
          currentScreen.value == Screen.orders;
    }
    return false;
  }

  // Helper methods to check inner screens
  bool isRegularInnerScreen() {
    return (currentScreen.value == Screen.regular ||
            currentScreen.value == Screen.shifts) &&
        currentParentMenu.value == "Regular";
  }

  bool isRestaurantInnerScreen() {
    return (currentScreen.value == Screen.restaurant ||
            currentScreen.value == Screen.newOrder ||
            currentScreen.value == Screen.activeOrder ||
            currentScreen.value == Screen.kitchen ||
            currentScreen.value == Screen.delivery ||
            currentScreen.value == Screen.pickup ||
            currentScreen.value == Screen.tables ||
            currentScreen.value == Screen.fastfood ||
            currentScreen.value == Screen.orders ||
            currentScreen.value == Screen.shifts) &&
        currentParentMenu.value == "Restaurant";
  }

  bool isFastFoodInnerScreen() {
    return (currentScreen.value == Screen.newOrder ||
            currentScreen.value == Screen.activeOrder ||
            currentScreen.value == Screen.kitchen ||
            currentScreen.value == Screen.fastfood ||
            currentScreen.value == Screen.shifts ||
            currentScreen.value == Screen.orders) &&
        currentParentMenu.value == "Fast Food";
  }

  bool isSuperMarketInnerScreen() {
    return (currentScreen.value == Screen.superMarket ||
            currentScreen.value == Screen.newOrder ||
            currentScreen.value == Screen.orders ||
            currentScreen.value == Screen.shifts) &&
        currentParentMenu.value == "Super Market";
  }

  bool isInnerSelected(int index) {
    if (index < 10) {
      if (index == 0) {
        return isRegularInnerScreen();
      } else if (index == 1) {
        return isRestaurantInnerScreen();
      } else if (index == 2) {
        return isFastFoodInnerScreen();
      } else if (index == 3) {
        return isSuperMarketInnerScreen();
      } else if (index == 4) {
        return currentScreen.value == Screen.onlineOrder;
      }
    }

    // Regular inner items (10-19)
    if (index >= 10 && index < 20) {
      switch (index - 10) {
        case 0:
          return currentScreen.value == Screen.shifts;
        default:
          return false;
      }
    }

    // Restaurant inner items (20-29)
    if (index >= 20 && index < 30) {
      switch (index - 20) {
        case 0:
          return currentScreen.value == Screen.activeOrder;
        case 1:
          return currentScreen.value == Screen.newOrder;
        case 2:
          return currentScreen.value == Screen.kitchen;
        case 3:
          return currentScreen.value == Screen.tables;
        case 4:
          return currentScreen.value == Screen.fastfood;
        case 5:
          return currentScreen.value == Screen.orders;
        case 6:
          return currentScreen.value == Screen.shifts;
        case 7:
          return currentScreen.value == Screen.help;
        default:
          return false;
      }
    }

    // Fast Food inner items (30-39)
    if (index >= 30 && index < 39) {
      switch (index - 30) {
        case 0:
          return currentScreen.value == Screen.activeOrder;
        case 1:
          return currentScreen.value == Screen.newOrder;
        case 2:
          return currentScreen.value == Screen.kitchen;
        case 3:
          return currentScreen.value == Screen.fastfood;
        case 4:
          return currentScreen.value == Screen.orders;
        case 5:
          return currentScreen.value == Screen.shifts;
        case 6:
          return currentScreen.value == Screen.help;
        default:
          return false;
      }
    }

    // Super Market inner items (40-49)
    if (index >= 40 && index < 49) {
      switch (index - 40) {
        case 0:
          return currentScreen.value == Screen.newOrder;
        case 1:
          return currentScreen.value == Screen.shifts;
        case 4:
          return currentScreen.value == Screen.orders;
        default:
          return false;
      }
    }

    return false;
  }

  bool shouldShowBackButton() {
    // Show back button only for NewOrder and ActiveOrder screens
    return currentScreen.value == Screen.newOrder ||
        currentScreen.value == Screen.activeOrder ||
        currentScreen.value == Screen.kitchen ||
        currentScreen.value == Screen.delivery ||
        currentScreen.value == Screen.pickup ||
        currentScreen.value == Screen.tables;
  }

  bool shouldShowSearchBar() {
    return currentScreen.value == Screen.regular;
  }

  bool shouldShowDropdowns() {
    return currentScreen.value == Screen.pickup ||
        currentScreen.value == Screen.superMarket ||
        currentScreen.value == Screen.fastfood;
  }

  bool shouldShowFilter() {
    return currentScreen.value == Screen.fastfood;
  }

  bool shouldShowCounts() {
    return currentScreen.value == Screen.kitchen;
  }

  bool shouldShowInnerItems(String title) {
    switch (title) {
      case "Regular":
        return isInnerSelected(0);
      case "Restaurant":
        return isInnerSelected(1);
      case "Fast Food":
        return isInnerSelected(2);
      case "Super Market":
        return isInnerSelected(3);
      default:
        return false;
    }
  }

  void onMenuTapped(BuildContext context, Size size, String title) {
    if (title == "Items") {
      Constants.openWideDialog(
        context: context,
        title: title,
        hintText: "Article",
        btnText1: "Add Product",
      );
    } else if (title == "Customers") {
      Constants.openWideDialog(
        context: context,
        title: title,
        hintText: "Client",
        btnText1: "Add Customer",
      );
    } else if (title == "Discard Order") {
      Constants.openAlertDialog(
        context: context,
        title: "Discard Order",
        msg: "Are you sure you want to cancel your cart ?",
        toastMsg: 'Order Discarded!',
      );
    } else if (title == "Discount") {
      Constants.openDialog(
        context: context,
        title: "Add Discount",
        btnText1: "Cancel",
        btnText2: "Submit",
        child: const CustomTextInput(hintText: "Discount"),
        height: size.height / 4,
      );
    } else if (title == "Setting") {
      Constants.openDialog(
        context: context,
        title: title,
        btnText1: "Proceed",
        height: size.height / 1.5,
        child: inputSection(),
      );
    } else if (title.contains("Close")) {
      Constants.openDialog(
        context: context,
        title: title,
        btnText1: "Submit",
        btnText2: "Close and Print",
        height: size.height / 2.5,
        child: closeShift(context),
      );
    } else if (title.contains("Deleted") || title.contains("Draft")) {
      Constants.openWideDialog(
        context: context,
        title: title,
        hintText: "Order",
      );
    } else if (title.contains("Orders")) {
      Constants.openWideDialog(
        context: context,
        title: title,
        hintText: "Order",
      );
    }
  }

  Widget closeShift(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 132.0,
          margin: const EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Themes.kGreyColor)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  closeShiftItems("Start Date", "bold"),
                  closeShiftItems("12/24/2024 12:15 AM", "normal"),
                ],
              ),
              Constants.divider(context, 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  closeShiftItems("Initial Base", "bold"),
                  closeShiftItems("DOP \$0.00", "normal"),
                ],
              ),
              Constants.divider(context, 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  closeShiftItems("Total", "bold"),
                  closeShiftItems("DOP \$0.00", "bold"),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        const CustomTextInput(hintText: "Observations"),
      ],
    );
  }

  Widget closeShiftItems(String title, String type) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: type == "bold" ? FontWeight.bold : FontWeight.normal,
        color: Themes.kBlackColor,
      ),
    );
  }

  Widget inputSection() {
    return Column(
      children: [
        CustomDropdowns(listData: DummyData.ncfItems, hintText: "NCF"),
        const SizedBox(height: 16.0),
        CustomDropdowns(
            listData: DummyData.bankAccountItems, hintText: "Bank Account"),
        const SizedBox(height: 16.0),
        CustomDropdowns(
            listData: DummyData.walletBankAccountItems,
            hintText: "Wallet Bank Account"),
        const SizedBox(height: 16.0),
        CustomDropdowns(
            listData: DummyData.templateItems, hintText: "Template"),
        const SizedBox(height: 16.0),
        CustomDropdowns(
            listData: DummyData.templateSelectionItems,
            hintText: "Template Selection"),
        const SizedBox(height: 16.0),
        CustomDropdowns(
            listData: DummyData.printerItems, hintText: "Default Printer"),
        const SizedBox(height: 16.0),
        CustomDropdowns(
            listData: DummyData.orderOfShowingItems,
            hintText: "Order of showing"),
      ],
    );
  }
}
