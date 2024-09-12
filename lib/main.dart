import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mac_store_app/provider/user_provider.dart';
import 'package:mac_store_app/theme.dart';
import 'package:mac_store_app/views/screens/authentication_screens/login_screen.dart';
import 'package:mac_store_app/views/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  // Run the flutter app wrapped in a ProviderScope for managing state
  runApp(const ProviderScope(child: MyApp()));
}

//Root widget of the application, a consummerWidget to consume state change
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  //Method to check the token and set the user data if availible
  Future<void> _checkTokenAndSetUser(WidgetRef ref) async {
    //obtain an instance of sharedPreference for local data storage
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Retrive the authentication token and user data stored locally.
    String? token = preferences.getString('auth_token');
    String? userJson = preferences.getString('user');

    // if both token and user data are availble, update the user state
    if (token != null && userJson != null) {
      ref.read(userProvider.notifier).setUser(userJson);
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const defaultTextStyle = TextStyle(
      fontFamily: 'IranYekan',
      color: LightThemeColors.primaryTextColor,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store App',
      theme: ThemeData(
        fontFamily: 'Dana',
        textTheme: TextTheme(
          bodyLarge: defaultTextStyle,
          bodySmall:
              defaultTextStyle.apply(color: LightThemeColors.secondryTextColor),
          titleLarge: defaultTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          titleMedium: defaultTextStyle.apply(
            color: LightThemeColors.secondryTextColor,
          ),
        ),
        colorScheme: const ColorScheme.light(
          primary: LightThemeColors.primaryColor,
          secondary: LightThemeColors.secondryColor,
          onSecondary: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: FutureBuilder(
          future: _checkTokenAndSetUser(ref),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final user = ref.watch(userProvider);
            return user != null ? const MainScreen() : const LoginScreen();
          },
        ),
      ),
    );
  }
}
