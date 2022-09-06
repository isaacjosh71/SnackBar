
import 'package:get/get.dart';
import 'package:snack_bar/data/repository/most_popular_repo.dart';
import 'package:snack_bar/models/product_model.dart';

class MostPopularController extends GetxController{
  final MostPopularRepo mostPopularRepo;
  MostPopularController({required this.mostPopularRepo});
  List<ProductModel> _mostPopularList=[];
  List<ProductModel> get mostPopularList => _mostPopularList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void>getMostPopularList() async{
      Response response = await mostPopularRepo.getMostPopularList();
      if (response.statusCode == 200){
        _mostPopularList=[];
        _mostPopularList.addAll(Product.fromJson(response.body).products);
        _isLoaded = true;
        update();
      }else{
      }
  }
}