import 'dart:ui';

import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  // Modern "Electric" Palette
  static const Color kPrimary = Color(0xFF0F172A); // Dark Midnight
  static const Color kAccent = Color(0xFF6366F1); // Electric Indigo
  static const Color kSecondary = Color(0xFF8B5CF6); // Soft Violet

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Very light cool grey
      body: Stack(
        children: [
          // 1. Dynamic Mesh Gradient Background
          Positioned(
            top: -100,
            right: -50,
            child: _buildCircleGradient(400, kAccent.withOpacity(0.4)),
          ),
          _buildMainGradientHeader(context),

          SafeArea(
            child: Column(
              children: [
                _buildTopAppBar(),
                const SizedBox(height: 10),
                _buildBalanceSection(),
                const SizedBox(height: 30),
                _buildGlassActionCard(),
                _buildBottomContentSheet(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildModernBottomNav(),
      floatingActionButton: _buildNeonFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // --- Background Decor ---
  Widget _buildCircleGradient(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  Widget _buildMainGradientHeader(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: const BoxDecoration(
        color: kPrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
    );
  }

  // --- UI Components ---
  Widget _buildTopAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAvatar(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Badge(
              child: Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: [kAccent, kSecondary]),
      ),
      child: const CircleAvatar(
        radius: 20,
        backgroundColor: kPrimary,
        child: Icon(Icons.person_outline, color: Colors.white),
      ),
    );
  }

  Widget _buildBalanceSection() {
    return const Column(
      children: [
        Text(
          "Total Portfolio",
          style: TextStyle(
            color: Colors.white60,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5),
        Text(
          "\$12,450.54",
          style: TextStyle(
            color: Colors.white,
            fontSize: 38,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),
      ],
    );
  }

  // GLASSMORPHISM CARD
  Widget _buildGlassActionCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 110,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _glassItem(Icons.add_rounded, "Top Up"),
                _glassItem(Icons.arrow_outward_rounded, "Send"),
                _glassItem(Icons.qr_code_2_rounded, "Receive"),
                _glassItem(Icons.pie_chart_outline_rounded, "Stats"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _glassItem(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kAccent.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomContentSheet() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Quick Services",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: kPrimary,
                ),
              ),
              const SizedBox(height: 20),
              _buildServiceGrid(),
              const SizedBox(height: 30),
              _buildModernPromoCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceGrid() {
    final services = [
      {
        'icon': Icons.flash_on_rounded,
        'label': 'Utility',
        'color': Colors.orange,
      },
      {'icon': Icons.wifi_rounded, 'label': 'Internet', 'color': Colors.blue},
      {
        'icon': Icons.movie_creation_outlined,
        'label': 'Tickets',
        'color': Colors.red,
      },
      {
        'icon': Icons.shopping_bag_outlined,
        'label': 'Shop',
        'color': Colors.teal,
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: services
          .map(
            (s) => _serviceItem(
              s['icon'] as IconData,
              s['label'] as String,
              s['color'] as Color,
            ),
          )
          .toList(),
    );
  }

  Widget _serviceItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildModernPromoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [kAccent, kSecondary],
          begin: Alignment.topLeft,
        ),
        boxShadow: [
          BoxShadow(
            color: kAccent.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cashback 25%",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  "On your first utility bill payment this month!",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.stars_rounded, color: Colors.white, size: 50),
        ],
      ),
    );
  }

  // --- Bottom Nav & FAB ---
  Widget _buildNeonFAB() {
    return Container(
      height: 65,
      width: 65,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(colors: [kAccent, kSecondary]),
        boxShadow: [
          BoxShadow(
            color: kAccent.withOpacity(0.5),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Icon(
        Icons.center_focus_strong_rounded,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  Widget _buildModernBottomNav() {
    return BottomAppBar(
      height: 80,
      notchMargin: 12,
      padding: EdgeInsets.zero,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.home_filled, color: kAccent),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.wallet_outlined), onPressed: () {}),
          const SizedBox(width: 40),
          IconButton(
            icon: const Icon(Icons.analytics_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
