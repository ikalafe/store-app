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
  late TextEditingController _stateController;
  late TextEditingController _cityController;
  late TextEditingController _localityController;

  // Show Loading Dialog
  _showLoadingDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'درحال به روز رسانی...',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    // Read the current user data from the provider
    final user = ref.read(userProvider);

    // Initialize the controllers with the current data if available
    // if user Data is not available, initialize with an empty String
    _stateController = TextEditingController(text: user?.state ?? '');
    _cityController = TextEditingController(text: user?.city ?? '');
    _localityController = TextEditingController(text: user?.locality ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
    final updateUser = ref.read(userProvider.notifier);
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
                  controller: _stateController,
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
                  controller: _cityController,
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
                  controller: _localityController,
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
              _showLoadingDialog();
              await _authController
                  .updateUserLocation(
                context: context,
                id: user!.id,
                state: _stateController.text,
                city: _cityController.text,
                locality: _localityController.text,
              )
                  .whenComplete(() {
                updateUser.recreateUserState(
                  state: _stateController.text,
                  city: _cityController.text,
                  locality: _localityController.text,
                );
                Navigator.pop(context); // This will close the Dialog
                Navigator.pop(
                    context); // This will close the Shipping screen meaning it will take us back to the previews
              });
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
