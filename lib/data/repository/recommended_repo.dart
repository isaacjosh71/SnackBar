
import 'package:get/get.dart';
import 'package:snack_bar/data/api/api_client.dart';
import 'package:snack_bar/helpers/app_const.dart';

class RecommendedRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedRepo({required this.apiClient});

  Future<Response> getRecommendedList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_URI);
  }
}