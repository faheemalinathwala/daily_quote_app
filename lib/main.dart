import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quote_provider.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const DailyQuoteApp());
}

class DailyQuoteApp extends StatelessWidget {
  const DailyQuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuoteProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Daily Quote',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF3F6FF),
          useMaterial3: true,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
