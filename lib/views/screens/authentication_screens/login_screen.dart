import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white.withOpacity(0.96),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login Your Accont',
                  style: GoogleFonts.getFont(
                    "Lato",
                    color: const Color(0xFF0d120E),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                    fontSize: 23,
                  ),
                ),
                Text(
                  'To Explorer the word exclusives',
                  style: GoogleFonts.getFont(
                    "Lato",
                    color: const Color(0xFF0d120E),
                    letterSpacing: 0.2,
                    fontSize: 14,
                  ),
                ),
                Image.asset(
                  'assets/images/image_login.png',
                  width: 200,
                  height: 200,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Email',
                    style: GoogleFonts.getFont('Nunito Sans',
                        fontWeight: FontWeight.w600, letterSpacing: 0.2),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    labelText: 'Enter your Email',
                    labelStyle: GoogleFonts.getFont(
                      'Nunito Sans',
                      fontSize: 14,
                      letterSpacing: 0.1,
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.email_outlined,
                        size: 32,
                        color: Color(0xFF0039a6),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Password',
                    style: GoogleFonts.getFont(
                      'Nunito Sans',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      labelText: 'Enter your Password',
                      labelStyle: GoogleFonts.getFont(
                        'Nunito Sans',
                        fontSize: 14,
                        letterSpacing: 0.1,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Iconsax.lock_1_copy,
                          size: 32,
                          color: Color(0xFF0039a6),
                        ),
                      ),
                      suffixIcon: const Icon(Iconsax.eye_copy)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 319,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF102DE1),
                        Color(0xcc0d6eff),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.getFont(
                        'Lato',
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Need an Account?',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Sign Up',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,  
                        letterSpacing: 1,
                        color: const Color(0xFF102DE1),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
