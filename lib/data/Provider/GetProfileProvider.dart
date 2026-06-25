import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/data/Model/GetProfileModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getProfileProvider = FutureProvider.autoDispose<GetProfileModel>((
  ref,
) async {
  final authservice = ref.read(authServiceProvider);
  return await authservice.getProfileData();
});
