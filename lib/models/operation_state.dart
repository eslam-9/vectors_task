import 'package:vector_math/vector_math_64.dart';

import 'operation_type.dart';
import 'vector_model.dart';
import 'point_model.dart';

class OperationState {
  final VectorOperationType? selectedOperation;
  final VectorModel? selectedVector1;
  final VectorModel? selectedVector2;
  final PointModel? selectedPoint;
  final Vector3? v1Cartesian;
  final Vector3? v2Cartesian;
  final Vector3? pointCartesian;
  final Vector3? result;
  final String? errorMessage;

  const OperationState({
    this.selectedOperation,
    this.selectedVector1,
    this.selectedVector2,
    this.selectedPoint,
    this.v1Cartesian,
    this.v2Cartesian,
    this.pointCartesian,
    this.result,
    this.errorMessage,
  });

  const OperationState.initial()
    : selectedOperation = null,
      selectedVector1 = null,
      selectedVector2 = null,
      selectedPoint = null,
      v1Cartesian = null,
      v2Cartesian = null,
      pointCartesian = null,
      result = null,
      errorMessage = null;
}
