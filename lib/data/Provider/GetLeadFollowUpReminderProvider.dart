import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/data/Model/GetFollowUpReminderModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getLeadFollowUpReminderProvider =
    FutureProvider.autoDispose<GetFollowUpReminderModel>((ref) async {
      final serivce = ref.read(authServiceProvider);
      return await serivce.getLeadFollowReminder();
    });
