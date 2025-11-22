import 'package:vector_math/vector_math_64.dart';

import '../models/coordinate_system.dart';
import '../models/operation_type.dart';

String formatVector3(Vector3 vector) {
  return '(${vector.x.toStringAsFixed(3)}, '
      '${vector.y.toStringAsFixed(3)}, '
      '${vector.z.toStringAsFixed(3)})';
}

String coordinateSystemLabel(CoordinateSystem system) {
  switch (system) {
    case CoordinateSystem.cartesian:
      return 'Cartesian';
    case CoordinateSystem.cylindrical:
      return 'Cylindrical';
    case CoordinateSystem.spherical:
      return 'Spherical';
  }
}

String coordinateComponentLabel(CoordinateSystem system, int index) {
  if (system == CoordinateSystem.cartesian) {
    if (index == 1) return 'x';
    if (index == 2) return 'y';
    return 'z';
  }
  if (system == CoordinateSystem.cylindrical) {
    if (index == 1) return 'r';
    if (index == 2) return 'φ (phi, degrees)';
    return 'z';
  }
  if (system == CoordinateSystem.spherical) {
    if (index == 1) return 'r';
    if (index == 2) return 'θ (theta, degrees)';
    return 'φ (phi, degrees)';
  }
  return '';
}

String operationSymbol(VectorOperationType type) {
  switch (type) {
    case VectorOperationType.addition:
      return '+';
    case VectorOperationType.subtraction:
      return '−';
  }
}
