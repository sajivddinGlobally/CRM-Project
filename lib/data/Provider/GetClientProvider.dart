import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/data/Model/GetClientModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getClientProvider = FutureProvider.autoDispose<GetClientModel>((
  ref,
) async {
  final authService = ref.read(authServiceProvider);
  return await authService.getClientData();
});