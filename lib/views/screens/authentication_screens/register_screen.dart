import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mac_store_app/controllers/auth_controller.dart';
import 'package:mac_store_app/views/screens/authentication_screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late String email;
  late String fullName;
  late String password;
  bool _isLoading = false;

  registerUser() async {
    setState(() {
      _isLoading = true;
    });
    await _authController
        .signUpUsers(
            context: context,
            email: email,
            fullName: fullName,
            password: password)
        .whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white.withOpacity(0.96),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'ایجاد حساب کاربری',
                    style: TextStyle(
                      color: Color(0xFF0d120E),
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                  Image.asset(
                    'assets/images/image_login.png',
                    width: 300,
                    height: 200,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'ایمیل',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) => email = value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'ایمیل را خالی است!';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
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
                      labelText: 'ایمیل خودرا وارد کنید',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Dana',
                        letterSpacing: 0.1,
                      ),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Iconsax.sms_copy,
                          size: 32,
                          color: Color(0xFF0039a6),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'نام و نام خانوادگی',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) => fullName = value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Full Name';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
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
                      labelText: 'نام و نام خانوادگی را وارد کنید',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Dana',
                        letterSpacing: 0.1,
                      ),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Iconsax.sms_copy,
                          size: 32,
                          color: Color(0xFF0039a6),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'رمز عبور',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) => password = value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'رمز عبود خالی است';
                      } else if (value.length < 8) {
                        return 'رمز عبور باید بیشتر از 8 کاراکتر باشد';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
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
                      labelText: 'رمز عبور خود را وارد کنید',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Dana',
                        letterSpacing: 0.1,
                      ),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Iconsax.lock_1_copy,
                          size: 32,
                          color: Color(0xFF0039a6),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        registerUser();
                      } else {
                        debugPrint('Failed');
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xff5796E4)),
                      child: Center(
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                'ثبت نام',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'آیا حساب کاربری دارید؟',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'ورود',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF102DE1),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
