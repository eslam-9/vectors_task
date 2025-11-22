import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/point_model.dart';
import '../utils/app_routes.dart';
import '../utils/format_utils.dart';
import '../viewmodels/operation_view_model.dart';
import '../viewmodels/points_view_model.dart';
import '../widgets/primary_button.dart';

import '../widgets/modern_card.dart';

class PointSelectionView extends ConsumerStatefulWidget {
  const PointSelectionView({super.key});

  @override
  ConsumerState<PointSelectionView> createState() => _PointSelectionViewState();
}

class _PointSelectionViewState extends ConsumerState<PointSelectionView> {
  PointModel? _selectedPoint;

  @override
  Widget build(BuildContext context) {
    final points = ref.watch(pointsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Select Point')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: points.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Color(0xFFCF6679),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'You need at least one point.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ModernCard(
                    child: Column(
                      children: [
                        Text(
                          'Choose a Point',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: const Color(0xFFBB86FC),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 24),
                        DropdownButtonFormField<PointModel>(
                          value: _selectedPoint,
                          decoration: const InputDecoration(
                            labelText: 'Select Point',
                          ),
                          items: points
                              .asMap()
                              .entries
                              .map(
                                (entry) => DropdownMenuItem(
                                  value: entry.value,
                                  child: Text(
                                    'Point ${entry.key + 1} '
                                    '(${coordinateSystemLabel(entry.value.system)})',
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedPoint = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'Calculate',
                    onPressed: () {
                      if (_selectedPoint == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a point.'),
                          ),
                        );
                        return;
                      }
                      final notifier = ref.read(operationProvider.notifier);
                      notifier.setPoint(_selectedPoint!);
                      notifier.calculateResult();
                      Navigator.of(context).pushNamed(AppRoutes.calculation);
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
