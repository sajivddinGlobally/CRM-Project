import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/data/Model/GetSaleDetilesModel.dart';
import 'package:riverpod/riverpod.dart';

final getSaleDetilesProvider = FutureProvider.family.autoDispose<GetSaleDetilesModel,String>((ref,id) async {
  final authService = ref.read(authServiceProvider);
  return await authService.getSaleDetailsData(id: id);
});
