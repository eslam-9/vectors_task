import 'coordinate_system.dart';

class PointModel {
  final CoordinateSystem system;
  final double v1;
  final double v2;
  final double v3;

  const PointModel({
    required this.system,
    required this.v1,
    required this.v2,
    required this.v3,
  });
}
