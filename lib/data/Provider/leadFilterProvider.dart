import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/data/Model/GetLeadModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final leadFilterProvider = FutureProvider.family
    .autoDispose<GetLeadModel, String>((ref, status) async {
      final service = ref.read(authServiceProvider);
      return await service.leadFilter(status: status);
    });
