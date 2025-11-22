import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/operation_state.dart';
import '../models/operation_type.dart';
import '../models/vector_model.dart';
import '../models/point_model.dart';
import '../models/coordinate_system.dart';
import '../services/coordinate_converter_service.dart';
import '../services/vector_operation_service.dart';

class OperationViewModel extends StateNotifier<OperationState> {
  final CoordinateConverterService _converter;
  final VectorOperationService _vectorService;

  OperationViewModel(this._converter, this._vectorService)
    : super(const OperationState.initial());

  void setOperation(VectorOperationType operation) {
    state = OperationState(
      selectedOperation: operation,
      selectedVector1: state.selectedVector1,
      selectedVector2: state.selectedVector2,
      selectedPoint: state.selectedPoint,
      v1Cartesian: state.v1Cartesian,
      v2Cartesian: state.v2Cartesian,
      pointCartesian: state.pointCartesian,
      result: state.result,
      errorMessage: null,
    );
  }

  void setVector1(VectorModel vector) {
    state = OperationState(
      selectedOperation: state.selectedOperation,
      selectedVector1: vector,
      selectedVector2: state.selectedVector2,
      selectedPoint: state.selectedPoint,
      v1Cartesian: state.v1Cartesian,
      v2Cartesian: state.v2Cartesian,
      pointCartesian: state.pointCartesian,
      result: state.result,
      errorMessage: null,
    );
  }

  void setVector2(VectorModel vector) {
    state = OperationState(
      selectedOperation: state.selectedOperation,
      selectedVector1: state.selectedVector1,
      selectedVector2: vector,
      selectedPoint: state.selectedPoint,
      v1Cartesian: state.v1Cartesian,
      v2Cartesian: state.v2Cartesian,
      pointCartesian: state.pointCartesian,
      result: state.result,
      errorMessage: null,
    );
  }

  void setPoint(PointModel point) {
    state = OperationState(
      selectedOperation: state.selectedOperation,
      selectedVector1: state.selectedVector1,
      selectedVector2: state.selectedVector2,
      selectedPoint: point,
      v1Cartesian: state.v1Cartesian,
      v2Cartesian: state.v2Cartesian,
      pointCartesian: state.pointCartesian,
      result: state.result,
      errorMessage: null,
    );
  }

  void calculateResult() {
    final operation = state.selectedOperation;
    final v1Model = state.selectedVector1;
    final v2Model = state.selectedVector2;
    final pointModel = state.selectedPoint;

    if (operation == null ||
        v1Model == null ||
        v2Model == null ||
        pointModel == null) {
      state = OperationState(
        selectedOperation: operation,
        selectedVector1: v1Model,
        selectedVector2: v2Model,
        selectedPoint: pointModel,
        v1Cartesian: null,
        v2Cartesian: null,
        pointCartesian: null,
        result: null,
        errorMessage: 'Please select operation, two vectors, and a point.',
      );
      return;
    }

    // Use the point's Cartesian position to derive angles (in degrees)
    // for cylindrical / spherical vector components, regardless of how
    // the point was originally entered.
    final pointCartesian = _converter.convertPointToCartesian(pointModel);
    final x = pointCartesian.x;
    final y = pointCartesian.y;
    final z = pointCartesian.z;

    double thetaDeg = 0;
    double phiDeg = 0;

    // φ: azimuth angle in the x–y plane.
    if (x != 0 || y != 0) {
      final phiRad = math.atan2(y, x);
      phiDeg = phiRad * 180 / math.pi;
    }

    // θ: polar angle from +z axis.
    final r = math.sqrt(x * x + y * y + z * z);
    if (r > 0) {
      final thetaRad = math.acos(z / r);
      thetaDeg = thetaRad * 180 / math.pi;
    }

    final v1Cartesian = _converter.convertVectorComponentsToCartesian(
      v1Model,
      thetaDeg: thetaDeg,
      phiDeg: phiDeg,
    );
    final v2Cartesian = _converter.convertVectorComponentsToCartesian(
      v2Model,
      thetaDeg: thetaDeg,
      phiDeg: phiDeg,
    );
    // pointCartesian already computed above.

    final operationResult = operation == VectorOperationType.addition
        ? _vectorService.add(v1Cartesian, v2Cartesian)
        : _vectorService.subtract(v1Cartesian, v2Cartesian);

    final finalPoint = operationResult;

    state = OperationState(
      selectedOperation: operation,
      selectedVector1: v1Model,
      selectedVector2: v2Model,
      selectedPoint: pointModel,
      v1Cartesian: v1Cartesian,
      v2Cartesian: v2Cartesian,
      pointCartesian: pointCartesian,
      result: finalPoint,
      errorMessage: null,
    );
  }

  void clear() {
    state = const OperationState.initial();
  }
}

final operationProvider =
    StateNotifierProvider<OperationViewModel, OperationState>(
      (ref) => OperationViewModel(
        CoordinateConverterService(),
        VectorOperationService(),
      ),
    );
