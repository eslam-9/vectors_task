import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/app_routes.dart';
import '../utils/format_utils.dart';
import '../viewmodels/operation_view_model.dart';
import '../widgets/primary_button.dart';

import '../widgets/modern_card.dart';

class CalculationView extends ConsumerWidget {
  const CalculationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(operationProvider);

    final hasError = state.errorMessage != null;
    final missingData =
        state.result == null ||
        state.v1Cartesian == null ||
        state.v2Cartesian == null ||
        state.pointCartesian == null ||
        state.selectedOperation == null;

    return Scaffold(
      appBar: AppBar(title: const Text('Calculation Result')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: hasError
            ? Center(
                child: ModernCard(
                  color: const Color(0xFFCF6679).withOpacity(0.1),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Color(0xFFCF6679),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFFCF6679),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : missingData
            ? const Center(child: Text('No result to show.'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ModernCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Input Data (Cartesian)',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: const Color(0xFFBB86FC),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 16),
                        _buildResultRow(
                          'Vector 1',
                          formatVector3(state.v1Cartesian!),
                        ),
                        const Divider(height: 24, color: Colors.white10),
                        _buildResultRow(
                          'Vector 2',
                          formatVector3(state.v2Cartesian!),
                        ),
                        const Divider(height: 24, color: Colors.white10),
                        _buildResultRow(
                          'Point',
                          formatVector3(state.pointCartesian!),
                        ),
                        const Divider(height: 24, color: Colors.white10),
                        _buildResultRow(
                          'Operation',
                          operationSymbol(state.selectedOperation!),
                          valueStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF03DAC6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ModernCard(
                    color: const Color(0xFF03DAC6).withOpacity(0.1),
                    child: Column(
                      children: [
                        const Text(
                          'Final Result',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF03DAC6),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          formatVector3(state.result!),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  PrimaryButton(
                    label: 'New Operation',
                    onPressed: () {
                      ref.read(operationProvider.notifier).clear();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.operationSelection,
                        (route) => route.isFirst,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      ref.read(operationProvider.notifier).clear();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.home,
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value, {TextStyle? valueStyle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        Text(
          value,
          style:
              valueStyle ??
              const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
