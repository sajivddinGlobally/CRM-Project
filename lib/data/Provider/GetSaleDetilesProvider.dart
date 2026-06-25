import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/data/Model/GetSaleDetilesModel.dart';
import 'package:riverpod/riverpod.dart';

final getSaleDetilesProvider = FutureProvider.autoDispose<GetSaleDetilesModel>((ref) async {
  final authService = ref.read(authServiceProvider);
  return await authService.getSaleDetailsData();
});
