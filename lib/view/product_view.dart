import 'package:app/controllers/product_controller.dart';
import 'package:app/models/products.dart';
import 'package:app/view/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final searchController = TextEditingController();
  final productController = Get.put(ProductController());
  final RxList<Products> filteredProducts = <Products>[].obs;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      filterProducts();
    });
    filteredProducts.assignAll(productController.productList); // Initialize list
  }

  void filterProducts() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredProducts.assignAll(productController.productList);
    } else {
      filteredProducts.assignAll(productController.productList
          .where((product) => product.category.toLowerCase().contains(query))
          .toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        automaticallyImplyLeading: false, 
        title: const Text(
          'Discover',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0, // Remove AppBar shadow
        actions: [
          IconButton(onPressed: () {
            
          }, icon: const Icon(Icons.notifications_outlined))
        ],
      ),
      backgroundColor: Colors.grey.shade200,
      // backgroundColor: Colors.grey.shade400,
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                Container(
                  margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Search',suffixIcon: const Icon(Icons.search_outlined),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Clearance Sales Section
                const Text(
                  'Best Seller',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 600, // Set your desired width
                  height: 250, // Set your desired height
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/iphone14.jpg'),
                      fit: BoxFit.cover, // Ensure the image covers the container
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(
                      //   'Up to 50% off',
                      //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      // ),
                      // Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Categories Section
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 50, // Height of the horizontal list
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      CategoryChip(label: 'All'),
                      CategoryChip(label: 'Smartphones'),
                      CategoryChip(label: 'Headphones'),
                      CategoryChip(label: 'Xbox'),
                      CategoryChip(label: 'Earphones'),
                      CategoryChip(label: 'Monitor'),
                      CategoryChip(label: 'Speakers'),
                      CategoryChip(label: 'TVs'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Product Grid Section
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), // Disable GridView scrolling
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: filteredProducts.isEmpty
                      ? productController.productList.length
                      : filteredProducts.length,
                  itemBuilder: (context, index) {
                    var product = filteredProducts.isEmpty
                        ? productController.productList[index]
                        : filteredProducts[index];
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
                          productController.setSelectProduct(product); // Set selected product
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
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                    child: Image.network(
                                      product.image, // Updated from `thumbnail` to `image`
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
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
                            // Favorite (Heart) Icon at the top-right corner
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
              ],
            ),
          ),
        );
      }),
    );
  }
}

// CategoryChip Widget
class CategoryChip extends StatelessWidget {
  final String label;

  const CategoryChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black87,
        width: 2, // Border width
        ),
      ),
      child: Center(
         child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold, // Set font weight to bold
          ),
        ),
      ),
    );
  }
}