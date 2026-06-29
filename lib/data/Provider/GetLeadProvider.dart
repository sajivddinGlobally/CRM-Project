import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/data/Model/GetLeadModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final leadProvider = FutureProvider.autoDispose<GetLeadModel>((ref) async {
  final authservice = ref.read(authServiceProvider);
  return await authservice.getLeadData();
});
