import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mac_store_app/common/utils.dart';
import 'package:mac_store_app/provider/cart_provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final cartData = ref.read(cartProvider);
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
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'شهر را وارد کنید',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
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
            Container(
              width: deviceWidth,
              height: 56,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              decoration: BoxDecoration(
                color: Color(0xff5796E4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'پرداخت',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
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
