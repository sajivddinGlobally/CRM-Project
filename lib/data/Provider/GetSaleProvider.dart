import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/data/Model/GetSaleModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getSaleProvider = FutureProvider.autoDispose<GetSaleModel>((ref) async {
  final authService = ref.read(authServiceProvider);
  return await authService.getSaleData();
});