import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mac_store_app/controllers/auth_controller.dart';
import 'package:mac_store_app/provider/user_provider.dart';

class ShippingAddressScreen extends ConsumerStatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends ConsumerState<ShippingAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late String state;
  late String city;
  late String locality;
  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.96),
      appBar: AppBar(
        elevation: 0,
        leading: ModalRoute.of(context)!.canPop
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 26,
                ))
            : null,
        title: const Text(
          'آدرس خریدار',
          style: TextStyle(fontFamily: 'Dana'),
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) => state = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'لطفا این قسمت را خالی نگزارید';
                    } else {
                      return null;
                    }
                  },
                  style: const TextStyle(fontFamily: 'Dana'),
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(
                      fontFamily: 'Dana',
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.blue.shade900,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.blue.shade500,
                      ),
                    ),
                    labelText: 'کشور',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Dana',
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  style: const TextStyle(fontFamily: 'Dana'),
                  onChanged: (value) => city = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'لطفا این قسمت را خالی نگزارید';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(
                      fontFamily: 'Dana',
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.blue.shade900,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.blue.shade500,
                      ),
                    ),
                    labelText: 'شهر',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Dana',
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  style: const TextStyle(fontFamily: 'Dana'),
                  onChanged: (value) => locality = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'لطفا این قسمت را خالی نگزارید';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(
                      fontFamily: 'Dana',
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.blue.shade900,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.blue.shade500,
                      ),
                    ),
                    label: const Text(
                      'آدرس محل سکونت',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Dana',
                        letterSpacing: 0.1,
                      ),
                    ),
                    alignLabelWithHint: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: InkWell(
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              await _authController.updateUserLocation(
                context: context,
                id: user!.id,
                state: state,
                city: city,
                locality: locality,
              );
            } else {
              print('not valid');
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0xff5796E4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text(
                'ذخیره',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
