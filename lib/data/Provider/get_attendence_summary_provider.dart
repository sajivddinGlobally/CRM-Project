import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/apiService/apiServiceProvider.dart';
import '../Model/AttendenceSummaryModel.dart';
import '../Model/attendence_history_response.dart';

final getAttendenceSummaryProvider = FutureProvider.autoDispose<AttendenceSummaryResponse>((ref) async {
  final authservice = ref.read(authServiceProvider);
  return await authservice.getAttendenceSummary();
});