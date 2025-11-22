import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/point_model.dart';
import '../models/coordinate_system.dart';

class PointsViewModel extends StateNotifier<List<PointModel>> {
  PointsViewModel() : super(const <PointModel>[]);

  void addPoint({
    required CoordinateSystem system,
    required double v1,
    required double v2,
    required double v3,
  }) {
    final point = PointModel(system: system, v1: v1, v2: v2, v3: v3);
    state = [...state, point];
  }

  void removePoint(PointModel point) {
    state = state.where((p) => p != point).toList();
  }

  void clearPoints() {
    state = const <PointModel>[];
  }
}

final pointsProvider = StateNotifierProvider<PointsViewModel, List<PointModel>>(
  (ref) => PointsViewModel(),
);
