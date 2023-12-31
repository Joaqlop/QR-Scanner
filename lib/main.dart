import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/providers.dart';
import 'package:qr_scanner/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.grey.shade200,
        systemNavigationBarDividerColor: Colors.grey.shade200,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Scanner',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomeScreen(),
          'maps': (_) => MapsScreen(),
        },
        theme: dataTheme(),
      ),
    );
  }

  ThemeData dataTheme() {
    return ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      useMaterial3: true,
      primaryColor: Colors.indigo,
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.grey.shade200,
        backgroundColor: Colors.indigo,
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.indigo,
        elevation: 5,
        highlightElevation: 0,
        foregroundColor: Colors.grey.shade200,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: false,
        backgroundColor: Colors.grey.shade200,
        selectedItemColor: Colors.grey.shade900,
        unselectedItemColor: Colors.grey.shade600,
      ),
    );
  }
}
