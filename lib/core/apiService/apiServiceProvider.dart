import 'package:crm_app/core/apiService/apiService.dart';
import 'package:crm_app/core/network/api.stateNetwork.dart';
import 'package:crm_app/core/utils/pretty.dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  return callDio();
});

final apiProvider = Provider<ApiStateNetwork>((ref) {
  final dio = ref.read(dioProvider);
  return ApiStateNetwork(dio);
});

final authServiceProvider = Provider<AuthService>((ref) {
  final api = ref.read(apiProvider);
  return AuthService(api);
});
