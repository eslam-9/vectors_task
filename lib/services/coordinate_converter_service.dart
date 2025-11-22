import 'dart:math' as math;

import 'package:vector_math/vector_math_64.dart';

import '../models/coordinate_system.dart';
import '../models/vector_model.dart';
import '../models/point_model.dart';

class CoordinateConverterService {
  Vector3 fromCartesian(double x, double y, double z) {
    return Vector3(x, y, z);
  }

  Vector3 convertVectorToCartesian(VectorModel vector) {
    return _convertToCartesian(vector.system, vector.v1, vector.v2, vector.v3);
  }

  Vector3 convertVectorComponentsToCartesian(
    VectorModel vector, {
    required double thetaDeg,
    required double phiDeg,
  }) {
    switch (vector.system) {
      case CoordinateSystem.cartesian:
        return _convertCartesianVector(vector);
      case CoordinateSystem.cylindrical:
        final phiRad = phiDeg * math.pi / 180;
        return _convertCylindricalVector(vector, phiRad);
      case CoordinateSystem.spherical:
        final thetaRad = thetaDeg * math.pi / 180;
        final phiRad = phiDeg * math.pi / 180;
        return _convertSphericalVector(vector, thetaRad, phiRad);
    }
  }

  Vector3 _convertCartesianVector(VectorModel v) {
    return Vector3(v.v1, v.v2, v.v3);
  }

  Vector3 _convertCylindricalVector(VectorModel v, double phiRad) {
    final Vr = v.v1;
    final Vphi = v.v2;
    final Vz = v.v3;

    final u_r = Vector3(math.cos(phiRad), math.sin(phiRad), 0);
    final u_phi = Vector3(-math.sin(phiRad), math.cos(phiRad), 0);
    final u_z = Vector3(0, 0, 1);

    return (u_r * Vr) + (u_phi * Vphi) + (u_z * Vz);
  }

  Vector3 _convertSphericalVector(
    VectorModel v,
    double thetaRad,
    double phiRad,
  ) {
    final Vr = v.v1;
    final Vtheta = v.v2;
    final Vphi = v.v3;

    final u_r = Vector3(
      math.sin(thetaRad) * math.cos(phiRad),
      math.sin(thetaRad) * math.sin(phiRad),
      math.cos(thetaRad),
    );

    final u_theta = Vector3(
      math.cos(thetaRad) * math.cos(phiRad),
      math.cos(thetaRad) * math.sin(phiRad),
      -math.sin(thetaRad),
    );

    final u_phi = Vector3(-math.sin(phiRad), math.cos(phiRad), 0);

    return (u_r * Vr) + (u_theta * Vtheta) + (u_phi * Vphi);
  }

  Vector3 convertPointToCartesian(PointModel point) {
    return _convertToCartesian(point.system, point.v1, point.v2, point.v3);
  }

  Vector3 _convertToCartesian(
    CoordinateSystem system,
    double v1,
    double v2,
    double v3,
  ) {
    switch (system) {
      case CoordinateSystem.cartesian:
        return fromCartesian(v1, v2, v3);
      case CoordinateSystem.cylindrical:
        final r = v1;
        final phiDeg = v2;
        final z = v3;
        final phi = phiDeg * math.pi / 180;
        final x = r * math.cos(phi);
        final y = r * math.sin(phi);
        return fromCartesian(x, y, z);
      case CoordinateSystem.spherical:
        final r = v1;
        final thetaDeg = v2;
        final phiDeg = v3;
        final theta = thetaDeg * math.pi / 180;
        final phi = phiDeg * math.pi / 180;
        final x = r * math.sin(theta) * math.cos(phi);
        final y = r * math.sin(theta) * math.sin(phi);
        final z = r * math.cos(theta);
        return fromCartesian(x, y, z);
    }
  }
}
