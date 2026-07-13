import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/apiService/apiServiceProvider.dart';
import '../Model/dashboard_response_model.dart' show DashboardResponseModel;

final dashboardProvider = FutureProvider.autoDispose<DashboardResponseModel>((
  ref,
) async {
  final authservice = ref.read(authServiceProvider);
  return await authservice.getDashboardData();
});
