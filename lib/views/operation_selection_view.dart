import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/operation_type.dart';
import '../utils/app_routes.dart';
import '../viewmodels/operation_view_model.dart';
import '../widgets/modern_card.dart';
import '../widgets/primary_button.dart';

class OperationSelectionView extends ConsumerWidget {
  const OperationSelectionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Operation')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ModernCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Choose Operation',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Select the calculation you want to perform',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  label: 'Addition (+)',
                  onPressed: () {
                    final notifier = ref.read(operationProvider.notifier);
                    notifier.clear();
                    notifier.setOperation(VectorOperationType.addition);
                    Navigator.of(context).pushNamed(AppRoutes.vectorSelection);
                  },
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Subtraction (−)',
                  onPressed: () {
                    final notifier = ref.read(operationProvider.notifier);
                    notifier.clear();
                    notifier.setOperation(VectorOperationType.subtraction);
                    Navigator.of(context).pushNamed(AppRoutes.vectorSelection);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
