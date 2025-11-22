import 'coordinate_system.dart';

class VectorModel {
  final String name;
  final CoordinateSystem system;
  final double v1;
  final double v2;
  final double v3;

  const VectorModel({
    required this.name,
    required this.system,
    required this.v1,
    required this.v2,
    required this.v3,
  });
}
