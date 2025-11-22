import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/vector_model.dart';
import '../utils/app_routes.dart';
import '../utils/format_utils.dart';
import '../viewmodels/operation_view_model.dart';
import '../viewmodels/vectors_view_model.dart';
import '../widgets/primary_button.dart';

import '../widgets/modern_card.dart';

class VectorSelectionView extends ConsumerStatefulWidget {
  const VectorSelectionView({super.key});

  @override
  ConsumerState<VectorSelectionView> createState() =>
      _VectorSelectionViewState();
}

class _VectorSelectionViewState extends ConsumerState<VectorSelectionView> {
  VectorModel? _vector1;
  VectorModel? _vector2;

  @override
  Widget build(BuildContext context) {
    final vectors = ref.watch(vectorsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Select Vectors')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: vectors.length < 2
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
                      'You need at least two vectors.\nCurrently: ${vectors.length}',
                      textAlign: TextAlign.center,
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
                          'Choose Vectors',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: const Color(0xFFBB86FC),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 24),
                        DropdownButtonFormField<VectorModel>(
                          value: _vector1,
                          decoration: const InputDecoration(
                            labelText: 'Select Vector 1',
                          ),
                          items: vectors
                              .map(
                                (v) => DropdownMenuItem(
                                  value: v,
                                  child: Text(
                                    '${v.name} '
                                    '(${coordinateSystemLabel(v.system)})',
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _vector1 = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<VectorModel>(
                          value: _vector2,
                          decoration: const InputDecoration(
                            labelText: 'Select Vector 2',
                          ),
                          items: vectors
                              .map(
                                (v) => DropdownMenuItem(
                                  value: v,
                                  child: Text(
                                    '${v.name} '
                                    '(${coordinateSystemLabel(v.system)})',
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _vector2 = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'Next',
                    onPressed: () {
                      if (_vector1 == null || _vector2 == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select two vectors.'),
                          ),
                        );
                        return;
                      }
                      final notifier = ref.read(operationProvider.notifier);
                      notifier.setVector1(_vector1!);
                      notifier.setVector2(_vector2!);
                      Navigator.of(context).pushNamed(AppRoutes.pointSelection);
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
