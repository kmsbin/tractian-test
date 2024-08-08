import 'package:tractian_test/app/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

import 'injectors/injector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Tractian',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('pt', 'BR'),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff121321),
          brightness: Brightness.light,
        ),
        fontFamily: 'Poppins',
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xffe4ebf0),
          focusedBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide(color: Colors.transparent)),
          border: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide(color: Colors.transparent)),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xfffafafa),
      ),
      routerConfig: goRouter,
    );
  }
}
