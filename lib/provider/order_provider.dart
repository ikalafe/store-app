import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mac_store_app/models/order_model.dart';

class OrderProvider extends StateNotifier<List<OrderModel>> {
  OrderProvider() : super([]);

  // Set the list of Orders
  void setOrders(List<OrderModel> orders) {
    state = orders;
  }
}

final orderProvider = StateNotifierProvider<OrderProvider, List<OrderModel>>(
  (ref) {
    return OrderProvider();
  },
);
