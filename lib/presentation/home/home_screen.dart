import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../sections/about_section.dart';
import '../sections/buyer_problems_section.dart';
import '../sections/contact_section.dart';
import '../sections/download_section.dart';
import '../sections/footer_section.dart';
import '../sections/hero_section.dart';
import '../sections/nav_bar.dart';
import '../sections/seller_problems_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  String _activeSection = 'home';
  final Map<String, GlobalKey> _sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'buyer': GlobalKey(),
    'seller': GlobalKey(),
    'download': GlobalKey(),
    'contact': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    String active = 'home';
    for (final entry in _sectionKeys.entries) {
      final renderBox =
          entry.value.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.attached) continue;
      final position = renderBox.localToGlobal(Offset.zero);
      if (position.dy < 200) {
        active = entry.key;
      }
    }
    if (active != _activeSection) {
      setState(() => _activeSection = active);
    }
  }

  void _scrollTo(String sectionId) {
    final key = _sectionKeys[sectionId];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      endDrawer: MobileDrawer(onNavTap: _scrollTo),
      body: Column(
        children: [
          NavBar(
            scrollController: _scrollController,
            activeSection: _activeSection,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Container(key: _sectionKeys['home'], child: const HeroSection()),
                  Container(key: _sectionKeys['about'], child: const AboutSection()),
                  Container(key: _sectionKeys['buyer'], child: const BuyerProblemsSection()),
                  Container(key: _sectionKeys['seller'], child: const SellerProblemsSection()),
                  Container(key: _sectionKeys['download'], child: const DownloadSection()),
                  Container(key: _sectionKeys['contact'], child: const ContactSection()),
                  FooterSection(onNavTap: _scrollTo),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
