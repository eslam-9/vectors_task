import 'package:flutter/material.dart';

import 'app_routes.dart';
import '../views/home_view.dart';
import '../views/add_vector_view.dart';
import '../views/add_points_view.dart';
import '../views/operation_selection_view.dart';
import '../views/vector_selection_view.dart';
import '../views/point_selection_view.dart';
import '../views/calculation_view.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case AppRoutes.addVectors:
        return MaterialPageRoute(builder: (_) => const AddVectorView());
      case AppRoutes.addPoints:
        return MaterialPageRoute(builder: (_) => const AddPointsView());
      case AppRoutes.operationSelection:
        return MaterialPageRoute(
          builder: (_) => const OperationSelectionView(),
        );
      case AppRoutes.vectorSelection:
        return MaterialPageRoute(builder: (_) => const VectorSelectionView());
      case AppRoutes.pointSelection:
        return MaterialPageRoute(builder: (_) => const PointSelectionView());
      case AppRoutes.calculation:
        return MaterialPageRoute(builder: (_) => const CalculationView());
      default:
        return MaterialPageRoute(builder: (_) => const HomeView());
    }
  }
}
