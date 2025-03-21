import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/controllers/product_controller.dart';
import 'package:app/view/product_detail.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites"),
        automaticallyImplyLeading: false, 
        ),
      
      backgroundColor: Colors.grey.shade200,
      body: Obx(() {
        if (productController.favoriteProducts.isEmpty) {
          return const Center(child: Text("No favorite products yet."));
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: 0.7,
            ),
            itemCount: productController.favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = productController.favoriteProducts[index];

              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    productController.setSelectProduct(product);
                    Get.to(() => ProductDetail());
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.network(
                                product.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black38,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Favorite IconColor.fromARGB(255, 110, 95, 94)t)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Obx(() => IconButton(
                              icon: Icon(
                                productController.favoriteProducts.contains(product)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: productController.favoriteProducts.contains(product)
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                productController.toggleFavorite(product);
                              },
                            )),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
