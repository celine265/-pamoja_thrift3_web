import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/theme/app_theme.dart';
import 'presentation/home/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pamoja Thrift',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      builder: (context, child) {
        return ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: const [
            Breakpoint(start: 0, end: 600, name: MOBILE),
            Breakpoint(start: 601, end: 900, name: TABLET),
            Breakpoint(start: 901, end: 1200, name: DESKTOP),
            Breakpoint(start: 1201, end: double.infinity, name: 'XL'),
          ],
        );
      },
      home: const HomeScreen(),
    );
  }
}
