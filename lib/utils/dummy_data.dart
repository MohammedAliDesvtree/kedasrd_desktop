import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/themes.dart';

class DummyData {
  static List<dynamic> productList = [
    {
      "id": 1,
      "image": Images.nachitos,
      "price": 10,
      "title": "Nachitos Ricos",
      "qty": 1
    },
    {
      "id": 2,
      "image": Images.hamberger,
      "price": 8,
      "title": "Fruit Salad",
      "qty": 1
    },
    {
      "id": 3,
      "image": Images.restaurant,
      "price": 18,
      "title": "Grilled Salmon",
      "qty": 1
    },
    {
      "id": 4,
      "image": Images.pastelitos,
      "price": 12,
      "title": "Vegetable Stir-Fry",
      "qty": 1
    },
    {
      "id": 5,
      "image": Images.bolitas,
      "price": 9,
      "title": "Chicken Tacos",
      "qty": 1
    },
    {
      "id": 6,
      "image": Images.hamberger,
      "price": 12,
      "title": "Beef Burger",
      "qty": 1
    },
    {
      "id": 7,
      "image": Images.restaurant,
      "price": 7,
      "title": "Caesar Salad",
      "qty": 1
    },
    {
      "id": 8,
      "image": Images.nachitos,
      "price": 15,
      "title": "Sushi Platter",
      "qty": 1
    },
    {
      "id": 9,
      "image": Images.pastelitos,
      "price": 14,
      "title": "Pasta Carbonara",
      "qty": 1
    },
    {
      "id": 10,
      "image": Images.hamberger,
      "price": 11,
      "title": "Margherita Pizza",
      "qty": 1
    },
    {
      "id": 11,
      "image": Images.storeBG,
      "price": 20,
      "title": "Steak Frites",
      "qty": 1
    },
    {
      "id": 12,
      "image": Images.restaurant,
      "price": 16,
      "title": "Tofu Stir-Fry",
      "qty": 1
    },
    {
      "id": 13,
      "image": Images.bolitas,
      "price": 9,
      "title": "Shrimp Scampi",
      "qty": 1
    },
    {
      "id": 14,
      "image": Images.nachitos,
      "price": 13,
      "title": "Quinoa Salad",
      "qty": 1
    },
    {
      "id": 15,
      "image": Images.fastFood,
      "price": 22,
      "title": "BBQ Ribs",
      "qty": 1
    },
    {
      "id": 16,
      "image": Images.pastelitos,
      "price": 17,
      "title": "Lobster Roll",
      "qty": 1
    },
  ].obs;

  static List<dynamic> dashboardList = [
    {"icon": Images.regularIc, "image": Images.regular, "title": "Regular"},
    {
      "icon": Images.restaurantIc,
      "image": Images.restaurant,
      "title": "Restaurant"
    },
    {"icon": Images.fastFoodIc, "image": Images.fastFood, "title": "Fast Food"},
    {
      "icon": Images.superMarketIc,
      "image": Images.superMarket,
      "title": "Super Market"
    },
    {
      "icon": Images.onlineOrderIc,
      "image": Images.onlineOrder,
      "title": "Online Store"
    },
  ];

  static List<dynamic> restaurantList = [
    {"image": Images.newOrder, "title": "New Order"},
    {"image": Images.activeOrder, "title": "Active Order"},
    {"image": Images.kitchen, "title": "Kitchen"},
  ];

  static List<dynamic> newOrderList = [
    {"image": Images.dineIn, "title": "Dine In"},
    {"image": Images.delivery, "title": "Delivery"},
    {"image": Images.pickUp, "title": "Pickup"},
  ];

  static List<dynamic> activeOrderList = [
    {"image": Images.dineIn, "title": "Dine In"},
    {"image": Images.delivery, "title": "Delivery"},
  ];

  static List<String> filterItems = [
    'All',
    'BEBIDAS-',
    'Beverages',
    'Beers',
    'Sides',
    'Juices',
    'Tickets',
    'ESPECIALES',
    'SALCHICHAS',
    'Snacks',
    'Dessert',
    'BURRITOS',
    'Meals',
    'HOTDOG/HAMB',
    'YAROA',
    'ALITAS',
    'PECHUGA',
    'Aqua',
    'Refrescos',
    'Adicionales',
    'Gustitos Ricos',
    'Mariscos',
    'Platos Fuertes',
    'Los Catadores',
    'Los Fuertes',
    'Services',
  ];

  static List<String> restaurantItems = [
    'New Order',
    'Active Order',
    'Kitchen'
  ];

  static List<dynamic> superMarketItems = [
    'Search Customer',
    'Search Item by Name',
    'Select Currency'
  ];

  static List<dynamic> superMarketButtonItems = [
    {"title": 'Items', "color": Themes.kPrimaryColor},
    {"title": 'Customers', "color": const Color(0xFFFFB84D)},
    {"title": 'Orders', "color": Themes.kGreenColor},
    {"title": 'Save Order', "color": const Color(0xFFF18C52)},
    {"title": 'Discard Order', "color": const Color(0xFFFC7373)},
    {"title": 'Discount', "color": const Color(0xFFDB91F1)},
  ];

  static List<dynamic> superMarketCartDeskItems = [
    {"title": 'Cash'},
    {"title": 'Card'},
    {"title": 'Partial'},
    {"title": 'Prepaid'},
    {"title": 'Receivable'},
    {"title": 'Transfer'},
    {"title": 'Uber Eats'},
    {"title": 'Pedidos Ya'},
    {"title": 'Glovo'},
  ];

  static List<dynamic> tableTabs = [
    {"title": 'Main Room'},
    {"title": 'Inside Room'},
    {"title": 'Outside Room'},
    {"title": 'Balcony Side'},
    {"title": 'Near Balcony'},
  ];

  static List<dynamic> ordersItems = [
    {"image": Images.draft, "title": "Draft"},
    {"image": Images.orders, "title": "All Orders"},
    {"image": Images.delete, "title": "Draft Orders Deleted"},
  ];

  static List<dynamic> homeDrawerItems = [
    // {"icon": Images.shifts, "title": "Dashboard"},
    {"icon": Images.shifts, "title": "POS"},
    // {"icon": Images.setting, "title": "Trash"},
  ];

  static List<dynamic> posDrawerItems = [
    {"icon": Images.shifts, "title": "Shifts"},
    // {"icon": Images.setting, "title": "Setting"},
    // {"icon": Images.exit, "title": "Exit"},
    // {"icon": Images.exit, "title": "Logout"},
  ];

  static List<dynamic> restaurantDrawerItems = [
    // {"icon": Images.home, "title": "Home"},
    {"icon": Images.newOrderIc, "title": "New Order"},
    {"icon": Images.checkout, "title": "Active Order"},
    {"icon": Images.kitchenIc, "title": "Kitchen"},
    {"icon": Images.bar, "title": "Bar"},
    {"icon": Images.table, "title": "Table"},
    {"icon": Images.category, "title": "Categories"},
    {"icon": Images.list, "title": "Orders"},
    {"icon": Images.shifts, "title": "Shifts"},
    // {"icon": Images.setting, "title": "Setting"},
    {"icon": Images.help, "title": "Help"},
    // {"icon": Images.exit, "title": "Exit"},
    // {"icon": Images.exit, "title": "Logout"},
  ];

  static List<dynamic> fastFoodDrawerItems = [
    {"icon": Images.newOrderIc, "title": "New Order"},
    {"icon": Images.checkout, "title": "Active Order"},
    {"icon": Images.kitchenIc, "title": "Kitchen"},
    {"icon": Images.category, "title": "Categories"},
    {"icon": Images.list, "title": "Orders"},
    {"icon": Images.shifts, "title": "Shifts"},
    // {"icon": Images.setting, "title": "Setting"},
    {"icon": Images.help, "title": "Help"},
    // {"icon": Images.exit, "title": "Exit"},
    // {"icon": Images.exit, "title": "Logout"},
  ];

  static List<dynamic> superMarketDrawerItems = [
    {"icon": Images.newOrderIc, "title": "New Order"},
    {"icon": Images.shifts, "title": "Shifts"},
    // {"icon": Images.setting, "title": "Setting"},
    {"icon": Images.items, "title": "Items"},
    {"icon": Images.customer, "title": "Customers"},
    {"icon": Images.list, "title": "Orders"},
    {"icon": Images.discard, "title": "Discard Order"},
    {"icon": Images.discount, "title": "Discount"},
    // {"icon": Images.exit, "title": "Exit"},
    // {"icon": Images.exit, "title": "Logout"},
  ];

  static List<dynamic> onlineStoreDrawerItems = [
    // {"icon": Images.home, "title": "Home"},
    {"icon": Images.telephone, "title": "Contact"},
  ];

  // List of items in our dropdown menu
  static List<String> currencyItems = [
    "Dollars - USD (USD \$)",
    "New Manats - AZN (MaH)",
    "Convertible Marka - BAM (KM)",
    "Leke All (Lek)",
  ];

  static List<String> priceListItems = [
    "Price List",
  ];

  static List<String> categoryItems = [
    "Nachitos Ricos",
    "Fruit Salad",
    "Grilled Salmon",
    "Vegetable Stir-Fry",
    "Chicken Tacos",
    "Beef Burger",
    "Caesar Salad",
    "Sushi Platter",
    "Pasta Carbonara",
    "Margherita Pizza",
    "Steak Frites",
    "Tofu Stir-Fry",
    "Shrimp Scampi",
    "Quinoa Salad",
    "BBQ Ribs",
    "Lobster Roll",
  ];

  static List<String> ncfItems = [
    "Factura Con Credito Fiscal B01",
  ];

  static List<String> bankAccountItems = [
    "2001 - Accounts payable",
    "2001 - Credit card",
    "100201 - Banco Popular DOP\$",
    "100202 - Banco Popular USD\$*0733",
  ];

  static List<String> walletBankAccountItems = [
    "2001 - Accounts payable",
  ];

  static List<String> templateItems = [
    "Template 80MM",
    "Template 58MM",
    "Template 58MM NL",
    "Template 80MM NL",
    "Template 80MM C",
    "Template 58MM C",
    "Template 80MM R",
    "Template 58MM R",
    "Template 80MM RL",
    "Template 58MM RL",
    "Template 80MM WL",
    "Template 58MM WL",
  ];

  static List<String> templateSelectionItems = [
    "Enable",
    "Disable",
  ];

  static List<String> agentsItems = [
    "Sirena",
  ];

  static List<String> taxItems = [
    "Custom (0%)",
    "AFP (2.87%)",
    "ISC (10%)",
  ];

  static List<String> cardItems = [
    "Credit Card",
    "Debit Card",
  ];

  static List<String> typeItems = [
    "Cash",
    "Credit Card",
    "Debit Card",
    "Prepaid",
    "Receivable",
    "Transfer"
  ];

  static List<String> printerItems = ["Windows", "Web"];

  static List<String> orderOfShowingItems = ["Top", "Bottom"];

  static List<String> ordersFilters = ["Today", "Yesterday", "Last 7 Days"];

  static List<String> exportItems = ["Export PDF", "Export Excel"];

  static List<String> actionItems = ["Confirm By Whatsapp", "Send By Email"];

  static List<String> cartOptionsItems = ["Print Pre-Bill", "Clear Cart"];

  static List<String> cartSingleItems = [
    "Add Extra Items",
    "Add Notes",
    "Send to Kitchen",
    "Send to Bar",
    "Remove"
  ];

  static List<String> payItems = [
    'Cash',
    'Credit Card',
    'Transfer',
    'Partial Payment',
    'Prepaid Balance',
    'Receivable',
    'Uber Eats',
    'Pedidos Ya',
    'Glovo'
  ];

  static List<String> notificationItems = [
    "Order #141332 in restaurant and fastfood pos has been deleted it exceeded the limit of 48 hours",
    "Order #141332 in restaurant and fastfood pos has been deleted it exceeded the limit of 48 hours",
    "Order #141332 in restaurant and fastfood pos has been deleted it exceeded the limit of 48 hours",
    "Order #141332 in restaurant and fastfood pos has been deleted it exceeded the limit of 48 hours",
    "Order #141332 in restaurant and fastfood pos has been deleted it exceeded the limit of 48 hours",
    "Order #141332 in restaurant and fastfood pos has been deleted it exceeded the limit of 48 hours",
    "Order #141332 in restaurant and fastfood pos has been deleted it exceeded the limit of 48 hours",
    "Order #141332 in restaurant and fastfood pos has been deleted it exceeded the limit of 48 hours",
    "Order #141332 in restaurant and fastfood pos has been deleted it exceeded the limit of 48 hours",
    "Order #141332 in restaurant and fastfood pos has been deleted it exceeded the limit of 48 hours",
  ];

  static List<String> extraItems = [
    'Paneer',
    'Black Olives',
    'Red Peppers',
    'Mashroom',
    'Cheeze',
    "Vegitable",
    "Chicken"
  ];

  static List<String> formulaItems = ["No result found"];

  static List<String> tableModeItems = [
    "Only Table by Section",
    "All Tables",
  ];
}
