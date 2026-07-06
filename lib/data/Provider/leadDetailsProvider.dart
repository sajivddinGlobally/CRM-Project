import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/data/Model/leadDetailsModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final leadDetailsProvider = FutureProvider.family.autoDispose<LeadDetailsModel, String>((
  ref,
  id,
) async {
  final service = ref.read(authServiceProvider);
  return await service.leadDetailsData(id: id);
});
