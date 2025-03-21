import 'package:app/controllers/product_controller.dart';
import 'package:app/view/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({super.key});

  final productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Obx(() {
      final product = productController.selectedProduct.value;

      if (product == null) {
        return Scaffold(
          appBar: AppBar(title: const Text('Detail Product')),
          body: const Center(child: Text('No product selected.')),
        );
      }

      return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
            ),
            actions: [
              // Shopping Cart Icon with Count Badge
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Iconsax.shopping_cart_outline, size: 25, color: Colors.black),
                    onPressed: () {
                      Get.to(() => CartScreen());
                    },
                  ),
                  // Cart Item Count Badge
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Obx(() {
                      final cartItemCount = productController.cartItems.length;
                      if (cartItemCount > 0) {
                        return Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red, // Badge color
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            cartItemCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else {
                        return const SizedBox.shrink(); // Hide badge if cart is empty
                      }
                    }),
                  ),
                ],
              ),
              // Favorite Icon
              Obx(() => IconButton(
                    icon: Icon(
                      productController.isFavorite(productController.selectedProduct.value!)
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      size: 25,
                      color: productController.isFavorite(productController.selectedProduct.value!)
                          ? Colors.red
                          : Colors.black,
                    ),
                    onPressed: () {
                      productController.toggleFavorite(productController.selectedProduct.value!);
                    },
                  ),
              ),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
        ),
          // backgroundColor: Colors.grey.shade300,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                // Product Image (Now takes up more space)
                Expanded(
                  flex: 5, // 40% of the screen height
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                      image: DecorationImage(
                        image: NetworkImage(product.image),
                        fit: BoxFit.cover,
                        onError: (error, stackTrace) => const Icon(Icons.broken_image, size: 100, color: Colors.grey),
                      ),
                    ),
                  ),
                ),

                // Product Details (Takes up the rest of the screen)
                Expanded(
                  flex: 5, // 60% of the screen height
                  child: Container(
                    width: screenWidth,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 12, spreadRadius: 3, offset: Offset(0, -4)),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Title & Price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  product.title,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                "\$${product.price.toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // Delivery Time
                          const Row(
                            children: [
                              Icon(Icons.delivery_dining, color: Colors.black54, size: 22),
                              SizedBox(width: 6),
                              Text("Delivery in", style: TextStyle(fontSize: 15, color: Colors.black54)),
                              SizedBox(width: 4),
                              Text("60 min", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Quantity Selector
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.shade300,
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove, color: Colors.black),
                                      onPressed: () {
                                        productController.decreaseQuantity();
                                      },
                                    ),
                                    Obx(() => Text(
                                          productController.quantity.value.toString(),
                                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        )),
                                    IconButton(
                                      icon: const Icon(Icons.add, color: Colors.black),
                                      onPressed: () {
                                        productController.increaseQuantity();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Detail Introduction
                          const Text("Detail Introduction", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(
                            product.description,
                            style: const TextStyle(fontSize: 15, color: Colors.black54),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 16),

                          // Add to Cart Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black45,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () {
                                  if (productController.selectedProduct.value != null) {
                                    productController.addToCart(productController.selectedProduct.value!);
                                  }
                              },
                              child: const Text(
                                'Add to cart',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    }
  }