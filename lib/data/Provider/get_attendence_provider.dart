import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/apiService/apiServiceProvider.dart';
import '../Model/attendence_history_response.dart';

final getAttendenceHistoryProvider = FutureProvider.autoDispose<AttendenceHistoryResponse>((ref) async {
  final authservice = ref.read(authServiceProvider);
  return await authservice.getAttendenceHistory();
});