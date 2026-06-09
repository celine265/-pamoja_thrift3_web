import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../sections/contact_section.dart';
import '../sections/download_section.dart';
import '../sections/features_section.dart';
import '../sections/footer_section.dart';
import '../sections/hero_section.dart';
import '../sections/how_it_works_section.dart';
import '../sections/nav_bar.dart';
import '../sections/problem_solution_section.dart';

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
    'features': GlobalKey(),
    'problem-solution': GlobalKey(),
    'how-it-works': GlobalKey(),
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
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        children: [
          NavBar(
            scrollController: _scrollController,
            activeSection: _activeSection,
            onNavigate: _scrollTo,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Container(key: _sectionKeys['home'], child: HeroSection(onDownloadTap: () => _scrollTo('download'))),
                  Container(key: _sectionKeys['features'], child: const FeaturesSection()),
                  Container(key: _sectionKeys['problem-solution'], child: const ProblemSolutionSection()),
                  Container(key: _sectionKeys['how-it-works'], child: const HowItWorksSection()),
                  Container(key: _sectionKeys['download'], child: DownloadSection(onDownloadTap: () => _scrollTo('download'))),
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
