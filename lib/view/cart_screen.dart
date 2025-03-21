import 'package:app/models/products.dart';
import 'package:app/utils/navigation_menu.dart';
import 'package:app/view/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/controllers/product_controller.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('My Cart'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            NavigationController navController = Get.find<NavigationController>();

            if (Get.previousRoute.isNotEmpty) {
              Get.back(); // Normal back behavior
            } else {
              navController.selectedIndex.value = navController.lastIndex.value; // Return to last tab
            }
          },
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Obx(() {
        if (productController.cartItems.isEmpty) {
          return const Center(child: Text('No items in the cart.'));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: productController.cartItems.length,
                separatorBuilder: (context, index) => const Divider(
                color: Colors.grey, // Line under each item
                thickness: 1,
                height: 20
                ), // Separator between items
                itemBuilder: (context, index) {
                  final productEntry = productController.cartItems.entries.toList()[index];
                  final Products product = productEntry.key;
                  final int quantity = productEntry.value;

                  return ListTile(
                    onTap: () {
                    productController.setSelectProduct(product); // Set selected product
                     Get.to(() => ProductDetail());
                    },
                    leading: Image.network(
                      product.image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      product.title,
                      maxLines: 2, // Wrap title to 2 lines
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)} x $quantity'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline_rounded),
                          onPressed: () {
                            productController.removeFromCart(product);
                          },
                        ),
                        Text('$quantity',style: const TextStyle(fontSize: 16)),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline_rounded),
                          onPressed: () {
                            productController.addToCart(product);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.black45),
                          onPressed: () {
                            productController.removeItemCompletely(product);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 1), // Line above
                  bottom: BorderSide(color: Colors.grey, width: 1), // Line below
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Prevent taking extra space
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Obx(() => Text(
                            '\$${productController.getTotalPrice().toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                  const SizedBox(height: 8), // Add some spacing
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Fee:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      Text(
                        '\$3.00',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                    ],
                    ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Subtotal:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Obx(() => Text(
                            '\$${(productController.getTotalPrice() + 3).toStringAsFixed(2)}', // Add delivery fee to total
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement checkout logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black45,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
