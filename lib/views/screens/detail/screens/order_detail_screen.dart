import 'package:flutter/material.dart';
import 'package:mac_store_app/common/utils.dart';
import 'package:mac_store_app/models/order_model.dart';
import 'package:mac_store_app/views/screens/detail/screens/shipping_address_screen.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/image.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderModel order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: SizedBox(
              width: 140,
              child: Text(
                order.productName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontFamily: 'Dana'),
              )),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ImageLoadingService(
                  imageUrl: order.image,
                  widthImage: deviceWidth,
                  heithImage: deviceHeight * 0.3,
                  imageBorderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.productName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        height: 1.7,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'در دسته:',
                            style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            order.category,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'قیمت محصول:',
                            style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            convertToPersian(order.productPrice),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blue.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'وضعیت سفارش: ',
                            style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              color: order.delivered == true
                                  ? Colors.green
                                  : order.processing == true
                                      ? Colors.blue.shade900
                                      : Colors.red.shade400,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                order.delivered == true
                                    ? 'تحویل'
                                    : order.processing == true
                                        ? 'پردازش'
                                        : 'لغو شده',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: deviceWidth,
                      height: 1,
                      decoration: BoxDecoration(color: Colors.blue.shade400),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                    ),
                    Container(
                      height: 200,
                      width: deviceWidth,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 30),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade300,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              width: deviceWidth * 0.80,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      height: 1.8),
                                  'آدرس گیرنده: ${order.state} _ ${order.city} _ ${order.locality}',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: Text(
                              'نام گیرنده: ${order.fullName}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade50,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ShippingAddressScreen(),
                                ),
                              );
                            },
                            child: Center(
                              child: Container(
                                width: 200,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Text('ویرایش آدرس'),
                                ),
                              ),
                            ),
                          ),
                        ],
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
