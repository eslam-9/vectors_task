import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/vector_model.dart';
import '../models/coordinate_system.dart';

class VectorsViewModel extends StateNotifier<List<VectorModel>> {
  VectorsViewModel() : super(const <VectorModel>[]);

  void addVector({
    required String name,
    required CoordinateSystem system,
    required double v1,
    required double v2,
    required double v3,
  }) {
    final vector = VectorModel(
      name: name,
      system: system,
      v1: v1,
      v2: v2,
      v3: v3,
    );
    state = [...state, vector];
  }

  void removeVector(VectorModel vector) {
    state = state.where((v) => v != vector).toList();
  }

  void clearVectors() {
    state = const <VectorModel>[];
  }
}

final vectorsProvider =
    StateNotifierProvider<VectorsViewModel, List<VectorModel>>(
      (ref) => VectorsViewModel(),
    );
