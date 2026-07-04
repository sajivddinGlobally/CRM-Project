import 'package:crm_app/core/apiService/apiServiceProvider.dart';
import 'package:crm_app/data/Model/getNotificationModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getNotificationProvider = FutureProvider.autoDispose<GetNotficationModel>(
  (ref) async {
    final serivce = ref.read(authServiceProvider);
    return await serivce.getAllNotification();
  },
);
