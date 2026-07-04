import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/data/Model/GetClientDetailsModel.dart';
import 'package:riverpod/riverpod.dart';

final clientDetailsProvider = FutureProvider.family.autoDispose<GetClienDetailsModel,String>((
  ref,id
) async {
  final authservice = ref.read(authServiceProvider);
  return await authservice.getClientDetailsData(id: id);
});
