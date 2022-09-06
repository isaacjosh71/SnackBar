
import 'package:get/get.dart';
import 'package:snack_bar/models/product_model.dart';
import '../repository/recommended_repo.dart';

class RecommendedController extends GetxController{
  final RecommendedRepo recommendedRepo;
  RecommendedController({required this.recommendedRepo});
  List<ProductModel> _recommendedList=[];
  List<ProductModel> get recommendedList => _recommendedList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void>getRecommendedList() async{
    Response response = await recommendedRepo.getRecommendedList();
    if (response.statusCode == 200){
      _recommendedList=[];
      _recommendedList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    }else{
    }
  }
}