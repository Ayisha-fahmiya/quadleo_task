import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quadleo_machine_test/api%20model/user_data_model.dart';

class ApiServices {
  final Dio dio = Dio(
    BaseOptions(),
  );
  Future<GetUserDataApiModel?> getUserDataApi(int page) async {
    try {
      var endpoint =
          "https://customer.billerq.com/public/api/mobile/get-customer-details?page_length=10&page=$page";

      Response response = await dio.get(
        endpoint,
        options: Options(),
      );
      log("get all userdata statusCode: ${response.statusCode}");
      log(response.data['message']);

      if (response.statusCode! == 200) {
        var jsonResponse = json.encode(response.data);
        return getUserDataApiModelFromJson(jsonResponse);
      }
      return null;
    } on DioException catch (e) {
      log(e.toString());
      return null;
    }
  }
}

final userDataApiServicesProvider =
    StateProvider<ApiServices>((ref) => ApiServices());

final getAllUserDataProvider =
    FutureProvider.family<GetUserDataApiModel?, int>((ref, page) async {
  final apiServices = ref.read(userDataApiServicesProvider);
  return await apiServices.getUserDataApi(page);
});
