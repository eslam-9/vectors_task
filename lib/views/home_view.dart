import 'package:flutter/material.dart';

import '../utils/app_routes.dart';
import '../widgets/modern_card.dart';
import '../widgets/primary_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vector Operations')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Start by adding some vectors',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 48),
              ModernCard(
                child: Column(
                  children: [
                    const Icon(
                      Icons.add_circle_outline_rounded,
                      size: 48,
                      color: Color(0xFFBB86FC),
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      label: 'Add New Vector',
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.addVectors);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
