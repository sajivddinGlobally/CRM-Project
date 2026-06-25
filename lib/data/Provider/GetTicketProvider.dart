import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/data/Model/GetTicketModel.dart';
import 'package:riverpod/riverpod.dart';

final getTicketProvider = FutureProvider.autoDispose<GetTicketModel>((
  ref,
) async {
  final authService = ref.read(authServiceProvider);
  return await authService.getTicketData();
});
