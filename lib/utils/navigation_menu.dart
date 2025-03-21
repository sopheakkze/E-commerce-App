import 'package:app/personalization/settings/setting.dart';
import 'package:app/view/cart_screen.dart';
import 'package:app/view/favorite_screen.dart';
import 'package:app/view/product_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:icons_plus/icons_plus.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the globally initialized controller
    final controller = Get.find<NavigationController>();


    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          indicatorColor: Colors.black45, // Change the indicator color
          // onDestinationSelected: (index) => controller.selectedIndex.value = index,
          onDestinationSelected: (index) => controller.changeTab(index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home_outline, color: Colors.black), // Unselected icon color
              selectedIcon: Icon(Iconsax.home_outline, color:Colors.white70), // Selected icon color
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.shopping_cart_outline, color: Colors.black),
              selectedIcon: Icon(Iconsax.shopping_cart_outline, color: Colors.white70),
              label: 'Cart',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.heart_outline, color: Colors.black),
              selectedIcon: Icon(Iconsax.heart_outline, color: Colors.white70),
              label: 'Favorite',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.profile_tick_outline, color:  Colors.black),
              selectedIcon: Icon(Iconsax.profile_tick_outline, color: Colors.white70),
              label: 'Profile',
            ),
          ]
        ), 
      ),
      body: Obx(() => controller.screens [controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;
  final Rx<int> lastIndex = 0.obs; // Store the last tab index

  late final screens = [
    const ProductView(), 
    CartScreen(),
    const FavoriteScreen(), 
    const SettingScreen(),
  ];

    void changeTab(int index) {
    lastIndex.value = selectedIndex.value; // Save last tab
    selectedIndex.value = index;
  }
}