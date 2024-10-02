import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mac_store_app/common/utils.dart';
import 'package:mac_store_app/controllers/order_controller.dart';
import 'package:mac_store_app/provider/cart_provider.dart';
import 'package:mac_store_app/provider/user_provider.dart';
import 'package:mac_store_app/views/screens/detail/screens/shipping_address_screen.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String selectedPaymentMethod = 'درگاه پرداخت';
  final OrderController _orderController = OrderController();
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final cartData = ref.read(cartProvider);
    final _cartProvider = ref.read(cartProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        leading: ModalRoute.of(context)!.canPop
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 26,
                ))
            : null,
        centerTitle: true,
        title: const Text(
          'جزییات پرداخت',
          style: TextStyle(fontFamily: 'Dana'),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShippingAddressScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    height: 100,
                    width: deviceHeight,
                    decoration: BoxDecoration(
                      color: const Color(0xffEFF6FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Icon(
                                Iconsax.location_copy,
                                color: Color(0xff355B8A),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'آدرس را وارد کنید',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'استان را وارد کنید',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'شهر را وارد کنید',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Icon(
                            Iconsax.edit_copy,
                            color: Colors.blue.shade600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: deviceWidth,
                  height: 3,
                  decoration: const BoxDecoration(color: Color(0xffCEE3FD)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: Container(
                    width: 120,
                    height: 53,
                    decoration: const BoxDecoration(
                      color: Color(0xffCEE3FD),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      'سفارش شما',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4475B2)),
                    )),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Flexible(
              fit: FlexFit.tight,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final cartItem = cartData.values.toList()[index];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                cartItem.productName,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(convertToPersian(cartItem.productPrice))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 18),
                        width: deviceHeight,
                        height: 1,
                        decoration:
                            const BoxDecoration(color: Color(0xff94C3FC)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                },
                itemCount: cartData.length,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'روش پرداخت را انتخاب کنید',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: RadioListTile<String>(
                title: const Text(
                  'درگاه پرداخت',
                  style: TextStyle(fontFamily: 'Dana', fontSize: 18),
                ),
                value: 'درگاه پرداخت',
                groupValue: selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: RadioListTile<String>(
                title: const Text(
                  'پرداخت درب منزل',
                  style: TextStyle(fontFamily: 'Dana', fontSize: 18),
                ),
                value: 'پرداخت درب منزل',
                groupValue: selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
            ref.read(userProvider)!.state == ''
                ? InkWell(
                    focusColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ShippingAddressScreen()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      width: deviceWidth,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade800,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                          child: Text(
                        'لطفا آدرس خود را وارد کنید',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                    ),
                  )
                : InkWell(
                    focusColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      if (selectedPaymentMethod == 'درگاه پرداخت') {
                        // Pay with stripe to place the order
                      } else {
                        await Future.forEach(
                          _cartProvider.getCartItems.entries,
                          (entry) {
                            var item = entry.value;
                            _orderController.uploadOrders(
                              id: '',
                              fullName: ref.read(userProvider)!.fullName,
                              email: ref.read(userProvider)!.email,
                              // state: ref.read(userProvider)!.state,
                              state: 'ایران',
                              // city: ref.read(userProvider)!.city,
                              city: 'تهران',
                              // locality: ref.read(userProvider)!.locality,
                              locality:
                                  'شهریار_شاهد شهر_خیابان دکتر حسابی_کوچه شهریار_پلاک6_زرنگ 4',
                              productName: item.productName,
                              productPrice: item.productPrice,
                              quantity: item.quantity,
                              category: item.category,
                              image: item.image[0],
                              buyerId: ref.read(userProvider)!.id,
                              vendorId: item.vendorId,
                              processing: true,
                              delivered: false,
                              // ignore: use_build_context_synchronously
                              context: context,
                            );
                          },
                        );
                      }
                    },
                    child: Container(
                      width: deviceWidth,
                      height: 56,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 30),
                      decoration: BoxDecoration(
                        color: const Color(0xff5796E4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          selectedPaymentMethod == 'درگاه پرداخت'
                              ? 'پرداخت'
                              : 'ثبت سفارش',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
