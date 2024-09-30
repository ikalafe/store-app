import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mac_store_app/common/utils.dart';
import 'package:mac_store_app/provider/cart_provider.dart';
import 'package:mac_store_app/views/screens/detail/screens/checkout_screen.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/image.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final cartData = ref.watch(cartProvider);
    final _cartProvider = ref.read(cartProvider.notifier);
    final totalAmount = ref.read(cartProvider.notifier).calculateTotalAmount();
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(deviceHeight * 0.09),
          child: Container(
            margin: const EdgeInsets.only(right: 16, left: 16, bottom: 15),
            width: deviceWidth,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'سبد خرید',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Stack(
                  children: [
                    const Icon(
                      Iconsax.card_copy,
                      size: 30,
                    ),
                    Positioned(
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade700,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            '${cartData.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        body: cartData.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'سبد خرید خالیه!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    const Text(
                      'برایه ثبت سفارش به فروشگاه برو',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Image.asset(
                      'assets/images/empty_cart_image.png',
                    )
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      itemBuilder: (context, index) {
                        final cartItem = cartData.values.toList()[index];
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 16,
                                left: 16,
                                bottom: 16,
                              ),
                              child: Container(
                                width: deviceWidth,
                                height: 104,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Row(
                                        children: [
                                          ImageLoadingService(
                                            imageUrl: cartItem.image[0],
                                            widthImage: 87,
                                            heithImage: 87,
                                            imageBorderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 25),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    cartItem.productName,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    convertToPersian(
                                                        cartItem.productPrice),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 5, bottom: 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              _cartProvider.incrementCartItem(
                                                  cartItem.productId);
                                            },
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child:
                                                  const Icon(Iconsax.add_copy),
                                            ),
                                          ),
                                          Text(
                                            cartItem.quantity.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              cartItem.quantity < 2
                                                  ? _cartProvider
                                                      .removeCartItem(
                                                          cartItem.productId)
                                                  : _cartProvider
                                                      .decrementCartItem(
                                                          cartItem.productId);
                                            },
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: const Icon(
                                                  Iconsax.minus_copy),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      },
                      shrinkWrap: true,
                      itemCount: cartData.length,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        right: 16,
                        left: 16,
                        bottom: 30,
                      ),
                      width: deviceWidth,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(
                          0xffB6D6FD,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'جمع سبد خرید:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  convertToPersian(totalAmount.toInt()),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CheckoutScreen(),
                                ),
                              );
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              width: deviceWidth,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                  child: Text(
                                'پرداخت',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
