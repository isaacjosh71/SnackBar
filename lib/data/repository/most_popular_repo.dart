
import 'package:get/get.dart';
import 'package:snack_bar/data/api/api_client.dart';
import 'package:snack_bar/helpers/app_const.dart';

class MostPopularRepo extends GetxService{
  final ApiClient apiClient;
  MostPopularRepo({required this.apiClient});

  Future<Response> getMostPopularList() async{
    return await apiClient.getData(AppConstants.MOST_POPULAR_URI);
  }
}