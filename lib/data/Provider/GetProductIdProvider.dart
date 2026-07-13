import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/data/Model/GetProductIdModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productIdProvider = FutureProvider.autoDispose<ProductIdModel>((
  ref,
) async {
  final authservice = ref.read(authServiceProvider);
  return await authservice.getProductIdData();
});
