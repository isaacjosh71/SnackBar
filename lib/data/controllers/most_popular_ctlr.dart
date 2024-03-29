import 'package:get/get.dart';
import 'package:snack_bar/data/controllers/cart_contoller.dart';
import 'package:snack_bar/data/repository/most_popular_repo.dart';
import 'package:snack_bar/models/product_model.dart';
import '../../models/cart_model.dart';

class MostPopularController extends GetxController{
  final MostPopularRepo mostPopularRepo;
  MostPopularController({required this.mostPopularRepo});
  List<ProductModel> _mostPopularList=[];
  List<ProductModel> get mostPopularList => _mostPopularList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  late CartController _cart;

  //get most popular products data
  Future<void>getMostPopularList() async{
    Response response = await mostPopularRepo.getMostPopularList();
    if (response.statusCode == 200){
      print('got products');
      _mostPopularList=[];
      _mostPopularList.addAll(Product.fromJson(response.body).products);
      print(_mostPopularList);
      _isLoaded = true;
      update();
    }else{
    }
  }

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems= 0;
  int get inCartItems=>_inCartItems+_quantity;

  //product increments
  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity=checkQuantity(_quantity+1);
    } else{
      _quantity=checkQuantity(_quantity-1);
    }
    update();
  }

  //check increment range
  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar('Item Count', 'You can\'t reduce more');
      if(_inCartItems>0){
        _quantity=-_inCartItems;
        return _quantity;
      }
      return 0;}
    else if((_inCartItems+quantity)>10){
      Get.snackbar('Item Count', 'You can\'t add more');
      return 10;}
    else {return quantity;}
  }

  //init product when app refreshes
  void initProduct(ProductModel product, CartController cartC){
    _quantity=0;
    _inCartItems=0;
    _cart=cartC;
    var exist=false;
    exist=_cart.existInCart(product);
    if(exist){
      _inCartItems=_cart.getQuantity(product);
    }
  }

  //add products from cart controller
  void addItem(ProductModel product){
    _cart.addItem(product, _quantity);
    _quantity=0;
    _inCartItems=_cart.getQuantity(product);
    _cart.items.forEach((key, value) {});
    update();
  }

  //total products from cart controller
  int get totalItems{
    return _cart.totalItems;
  }

  //get
  List<CartModel> get getItems{
    return _cart.getItems;
  }
}