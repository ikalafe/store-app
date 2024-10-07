import 'package:flutter/material.dart';
import 'package:mac_store_app/controllers/auth_controller.dart';
import 'package:mac_store_app/views/screens/detail/screens/order_screen.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return AlertDialog(
            //       backgroundColor: const Color(0xffEFF6FF),
            //       title: const Padding(
            //         padding: EdgeInsets.all(8.0),
            //         child: Center(
            //           child: Text('مطمئنی می‌‌خوای بری؟'),
            //         ),
            //       ),
            //       content: SizedBox(
            //         width: 300,
            //         height: 200,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.only(bottom: 15.0),
            //               child: Image.asset(
            //                 'assets/images/notfound.png',
            //                 width: 130,
            //                 height: 130,
            //               ),
            //             ),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.end,
            //               children: [
            //                 InkWell(
            //                   onTap: () {
            //                     Navigator.pop(context);
            //                   },
            //                   child: Container(
            //                     width: 120,
            //                     height: 40,
            //                     decoration: BoxDecoration(
            //                       border: Border.all(
            //                           color: const Color(0xff60A5FA)),
            //                       borderRadius: BorderRadius.circular(12),
            //                       color: const Color(0xffEFF6FF),
            //                     ),
            //                     child: const Center(
            //                         child: Text(
            //                       'بستن',
            //                       style: TextStyle(
            //                         color: Color(0xff284569),
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                     )),
            //                   ),
            //                 ),
            //                 const SizedBox(
            //                   width: 20,
            //                 ),
            //                 InkWell(
            //                   onTap: () async {
            //                     await _authController.signOutUser(
            //                         context: context);
            //                   },
            //                   child: Container(
            //                     width: 120,
            //                     height: 40,
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(12),
            //                       color: const Color(0xff5796E4),
            //                     ),
            //                     child: const Center(
            //                         child: Text(
            //                       'بله',
            //                       style: TextStyle(
            //                         color: Colors.white,
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                     )),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // );
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const OrderScreen()));
          },
          child: const Text('سفارشات'),
        ),
      ),
    );
  }
}
