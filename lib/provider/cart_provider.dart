import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mac_store_app/models/cart_model.dart';

// Define a StateNotifierProvider to expose an instance of the CartNotifier
// Making i accessible within our app
final cartProvider =
    StateNotifierProvider<CartNotifier, Map<String, CartModel>>(
  (ref) => CartNotifier(),
);

// A Notifier class to manage the cart state, extending stateNotifier
// with an inital state of an empty map
class CartNotifier extends StateNotifier<Map<String, CartModel>> {
  CartNotifier() : super({});

  //Method to add product  to the cart
  void addProductToCart({
    required String productName,
    required int productPrice,
    required String category,
    required List<String> image,
    required String vendorId,
    required int productQuantity,
    required int quantity,
    required String productId,
    required String description,
    required String fullName,
  }) {
    // Check if the product is already in the cart
    if (state.containsKey(productId)) {
      // If the product is already in the cart, update its quantity and maybe other detail
      state = {
        ...state,
        productId: CartModel(
          productName: state[productId]!.productId,
          productPrice: state[productId]!.productPrice,
          category: state[productId]!.category,
          image: state[productId]!.image,
          vendorId: state[vendorId]!.vendorId,
          productQuantity: state[productId]!.productQuantity,
          quantity: state[productId]!.quantity + 1,
          productId: state[productId]!.productId,
          description: state[productId]!.description,
          fullName: state[productId]!.fullName,
        )
      };
    } else {
      // If the product is not in the cart, add it with the provid details
      state = {
        productId: CartModel(
          productName: productName,
          productPrice: productPrice,
          category: category,
          image: image,
          vendorId: vendorId,
          productQuantity: productQuantity,
          quantity: quantity,
          productId: productId,
          description: description,
          fullName: fullName,
        )
      };
    }
  }

  // Method to increment the quantity of a product in the cart
  void incrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity++;
      // Notify Listeners that the state has changed
      state = {...state};
    }
  }

  // Method to decrement the quantity of a product in the cart
  void decrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity--;
      //Notify Listners that the state has changed
      state = {...state};
    }
  }

  //Method to remove item from the cart
  void removeCartItem(String productId) {
    state.remove(productId);
    // Notify Listiners that the state has change
  }

  // Method to calculate total amount of items we have in cart
  double calculateTotalAmount() {
    double totalAmount = 0.0;
    state.forEach((productId, cartItem) {
      totalAmount += cartItem.quantity * cartItem.productPrice;
    });
    return totalAmount;
  }
}
