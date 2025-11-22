import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/coordinate_system.dart';
import '../utils/app_routes.dart';
import '../utils/format_utils.dart';
import '../viewmodels/vectors_view_model.dart';
import '../widgets/labeled_text_field.dart';
import '../widgets/modern_card.dart';
import '../widgets/primary_button.dart';

class AddVectorView extends ConsumerStatefulWidget {
  const AddVectorView({super.key});

  @override
  ConsumerState<AddVectorView> createState() => _AddVectorViewState();
}

class _AddVectorViewState extends ConsumerState<AddVectorView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _v1Controller = TextEditingController();
  final TextEditingController _v2Controller = TextEditingController();
  final TextEditingController _v3Controller = TextEditingController();

  CoordinateSystem _selectedSystem = CoordinateSystem.cartesian;

  @override
  void dispose() {
    _nameController.dispose();
    _v1Controller.dispose();
    _v2Controller.dispose();
    _v3Controller.dispose();
    super.dispose();
  }

  void _addVector() {
    final name = _nameController.text.trim();
    final v1 = double.tryParse(_v1Controller.text.trim());
    final v2 = double.tryParse(_v2Controller.text.trim());
    final v3 = double.tryParse(_v3Controller.text.trim());

    if (name.isEmpty || v1 == null || v2 == null || v3 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid name and numbers.')),
      );
      return;
    }

    ref
        .read(vectorsProvider.notifier)
        .addVector(name: name, system: _selectedSystem, v1: v1, v2: v2, v3: v3);

    _nameController.clear();
    _v1Controller.clear();
    _v2Controller.clear();
    _v3Controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final vectors = ref.watch(vectorsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Vectors')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ModernCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'New Vector Details',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFFBB86FC),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  LabeledTextField(
                    label: 'Vector Name',
                    controller: _nameController,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<CoordinateSystem>(
                    value: _selectedSystem,
                    decoration: const InputDecoration(
                      labelText: 'Coordinate System',
                    ),
                    items: CoordinateSystem.values
                        .map(
                          (system) => DropdownMenuItem(
                            value: system,
                            child: Text(coordinateSystemLabel(system)),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _selectedSystem = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: LabeledTextField(
                          label: coordinateComponentLabel(_selectedSystem, 1),
                          controller: _v1Controller,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: LabeledTextField(
                          label: coordinateComponentLabel(_selectedSystem, 2),
                          controller: _v2Controller,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: LabeledTextField(
                          label: coordinateComponentLabel(_selectedSystem, 3),
                          controller: _v3Controller,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(label: 'Add Vector', onPressed: _addVector),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: vectors.isEmpty
                  ? Center(
                      child: Text(
                        'No vectors added yet.',
                        style: TextStyle(color: Colors.white.withOpacity(0.5)),
                      ),
                    )
                  : ListView.builder(
                      itemCount: vectors.length,
                      itemBuilder: (context, index) {
                        final vector = vectors[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF2C2C2C),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.05),
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                vector.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                '${coordinateSystemLabel(vector.system)}: '
                                '(${vector.v1}, ${vector.v2}, ${vector.v3})',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Color(0xFFCF6679),
                                ),
                                onPressed: () {
                                  ref
                                      .read(vectorsProvider.notifier)
                                      .removeVector(vector);
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              label: 'Finish Adding Vectors',
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.addPoints);
              },
            ),
          ],
        ),
      ),
    );
  }
}
