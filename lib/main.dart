import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mac_store_app/theme.dart';
import 'package:mac_store_app/views/screens/authentication_screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  // Run the flutter app wrapped in a ProviderScope for managing state
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
      fontFamily: 'IranYekan',
      color: LightThemeColors.primaryTextColor,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: RegisterScreen(),
      ),
    );
  }
}
