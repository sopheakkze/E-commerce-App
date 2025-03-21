import 'package:app/models/products.dart';
import 'package:app/service/product_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {


  var productList = <Products>[].obs;
  final ProductService service = ProductService();
  var selectedProduct = Rxn<Products>();

  // var cartItems = <Products>[].obs; // Observable list 
  final RxList<Products> favoriteProducts = <Products>[].obs;
  var quantity = 1.obs; // Observable quantity

  var selectedQuantity = 1.obs; // Ensure it's initialized
  var cartItems = <Products, int>{}.obs; // Use a map to track quantity

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      var products = await service.fetchProducts();
      productList.assignAll(products);
    } catch (e) {
      print("Error: $e");
    }
  }

  void setSelectProduct(Products product) {
    selectedProduct.value = product;
    quantity.value = 1; // Reset quantity when selecting a new product
  }

  void toggleFavorite(Products product) {
    if (favoriteProducts.contains(product)) {
      favoriteProducts.remove(product);
    } else {
      favoriteProducts.add(product);
    }
  }

  bool isFavorite(Products product) {
    return favoriteProducts.contains(product);
  }

  // Increase quantity
  void increaseQuantity() {
    quantity.value++;
  }

  // Decrease quantity (minimum is 1)
  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void addToCart(Products product) {
  if (cartItems.containsKey(product)) {
    cartItems[product] = cartItems[product]! + quantity.value; // Use 'quantity' here
  } else {
    cartItems[product] = quantity.value; // Ensure correct quantity is stored
  }
  // Get.snackbar("Cart Updated", "${product.title} added to cart!",
  //     snackPosition: SnackPosition.BOTTOM);
}

  void removeFromCart(Products product) {
    if (cartItems.containsKey(product) && cartItems[product]! > 1) {
      cartItems[product] = cartItems[product]! - 1;
    } else {
      cartItems.remove(product);
    }
  }

  void removeItemCompletely(Products product) {
    cartItems.remove(product);
  }

  double getTotalPrice() {
    return cartItems.entries.fold(0, (sum, entry) => sum + (entry.key.price * entry.value));
  }


  

}
