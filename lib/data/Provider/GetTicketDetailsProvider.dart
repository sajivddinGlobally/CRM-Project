import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/data/Model/GetTicketDetailsModel.dart';
import 'package:riverpod/riverpod.dart';

final getTicketDetailsProvider =
    FutureProvider.autoDispose<GetTicketDetailsModel>((ref) async {
      final authservice = ref.read(authServiceProvider);
      return await authservice.getTicketDetailsData();
    });
