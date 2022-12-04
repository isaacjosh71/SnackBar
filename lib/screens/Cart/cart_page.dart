import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snack_bar/data/controllers/auth_ctlr.dart';
import 'package:snack_bar/data/controllers/cart_contoller.dart';
import 'package:snack_bar/data/controllers/location_controller.dart';
import 'package:snack_bar/data/controllers/most_popular_ctlr.dart';
import 'package:snack_bar/data/controllers/recommended_ctlr.dart';
import 'package:snack_bar/data/controllers/user_controller.dart';
import 'package:snack_bar/helpers/cart_foundation.dart';
import 'package:snack_bar/helpers/app_const.dart';
import 'package:snack_bar/helpers/router.dart';
import 'package:snack_bar/screens/Discover/address_page.dart';
import 'package:snack_bar/screens/Home/root_app.dart';
import 'package:snack_bar/widgets/make_paystack.dart';
import 'package:snack_bar/widgets/payment_option.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    var size=MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.97),
      body: Stack(
        children: [
          Positioned(
            top: size.height*0.075,
              left: size.width*0.005,
              right: size.width*0.005,
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.orangeAccent,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white70,
                        size: 24,
                      ),
                      onPressed: () {
                        Get.back();
                      },),
                  ),
                  SizedBox(
                    width: size.width*0.35,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.orangeAccent,
                    child: IconButton(
                      icon: const Icon(
                        Icons.home,
                        color: Colors.white70,
                        size: 24,
                      ),
                      onPressed: () {Get.toNamed(RouteHelper.getInitial());},),
                  ),
                  SizedBox(
                    width: size.width*0.05,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.orangeAccent,
                    child: IconButton(
                      icon: const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white70,
                        size: 24,
                      ),
                      onPressed: () {},),
                  ),
                ],
              )),
          GetBuilder<CartController>(builder: (_cartC){
            return _cartC.getItems.isNotEmpty
                ? Positioned(
                top: size.height*0.15,
                left: size.width*0.05,
                right: size.width*0.05,
                bottom: 0,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartC){
                    var _cartList = cartC.getItems;
                    return ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder: (_, index){
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: Container(
                              width: double.maxFinite,
                              height: MediaQuery.of(context).size.height * 0.12,
                              margin: const EdgeInsets.only(left: 5, right: 5, top: 10,bottom: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFA),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      var mostPopularIndex = Get.find<MostPopularController>()
                                          .mostPopularList
                                          .indexOf(_cartList[index].product!);
                                      if(mostPopularIndex>=0){
                                        Get.toNamed(RouteHelper.getMostPopular(mostPopularIndex,'cartPage'));
                                      }else{
                                        var recommendedIndex = Get.find<RecommendedController>()
                                            .recommendedList
                                            .indexOf(_cartList[index].product!);
                                        if(recommendedIndex<0){
                                          Get.snackbar('History Product', 'Product review is not available for history products');
                                        }else{
                                          Get.toNamed(RouteHelper.getRecommended(recommendedIndex, 'cartPage'));
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: MediaQuery.of(context).size.height * 0.12,
                                      width: MediaQuery.of(context).size.width * 0.30,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(topLeft:Radius.circular(10),
                                            bottomLeft: Radius.circular(10) ),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.BASE_URL+AppConstants.UPLOAD+cartC.getItems[index].img!
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width*0.05,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: MediaQuery.of(context).size.height * 0.12,
                                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(cartC.getItems[index].name!,
                                            style: const TextStyle(color: Colors.blue,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height*0.02,
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: size.height*0.045,
                                                  width: size.width*0.1,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(7),
                                                      color: Colors.grey.shade200
                                                  ),
                                                  child: Center(
                                                    child: Text(cartC.getItems[index].price.toString(),
                                                      style: const TextStyle(color: Colors.black87),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: size.width*0.18,),
                                                Container(
                                                  height: size.height*0.05,
                                                  width: size.width*0.18,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(7),
                                                      color: Colors.grey.shade200
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        GestureDetector(
                                                          child: const Icon(Icons.remove,size: 17,
                                                            color: Colors.black87,),
                                                          onTap: (){
                                                            cartC.addItem(_cartList[index].product!, -1);
                                                          },
                                                        ),
                                                        const SizedBox(width: 5,),
                                                        Text(_cartList[index].quantity.toString()),
                                                        const SizedBox(width: 5,),
                                                        GestureDetector(
                                                          child: const Icon(Icons.add,size: 17,
                                                            color: Colors.black87,),
                                                          onTap: (){
                                                            cartC.addItem(_cartList[index].product!, 1);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),),
                                ],
                              ),
                            ),
                          );
                        });
                  }),
                ))
                : const CartFoundation(text: 'Your cart is empty');
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<UserController>(builder: (userC){
        return GetBuilder<CartController>(builder: (cartC){
          controller.text=cartC.note;
          return Container(
              height: size.height * 0.15,
              padding: EdgeInsets.only( left: size.width * 0.085,
                  right: size.width * 0.10),
              decoration: BoxDecoration(
                color: const Color(0xFFE6E9ED).withOpacity(0.5),
              ),
              child: cartC.getItems.isNotEmpty
                  ?
              Column(
                children: [
                  InkWell(
                    onTap: ()=>showModalBottomSheet(context: context,
                        backgroundColor: Colors.transparent,
                        builder:(_){
                          return Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height*0.9,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10), topLeft: Radius.circular(10)
                                        )
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 520,
                                          padding: EdgeInsets.only(
                                            left: 15, right: 15,
                                          ),
                                          child: Column(
                                            children: [
                                              const PaymentOption(iconData: Icons.money,
                                                  title: "Cash on delivery",
                                                  subtitle: "you can pay on delivery",
                                                  index: 0),
                                              SizedBox(height: 10,),
                                              PaymentOption(iconData: Icons.paypal_sharp,
                                                  title: "Digital payment",
                                                  subtitle: "you can pay by transfer",
                                                  index: 0),
                                              SizedBox(height: 10,),
                                              Text('Additional notes', style: TextStyle(fontSize: 17),),
                                              TextField(
                                                controller: controller,
                                                decoration: InputDecoration(
                                                    hintText: '', prefixIcon: Icon(Icons.note, color: Colors.orangeAccent,)
                                                ),
                                              )
                                            ],
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).whenComplete(() => cartC.sendFoodNote(controller.text.trim())),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Container(
                        padding: EdgeInsets.only( bottom: size.width * 0.02,
                            top: size.width * 0.04,
                            left: size.width*0.05, right: size.width*0.05),
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 5),
                                  blurRadius: 10, color:Colors.orangeAccent
                              )
                            ],
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(13)
                        ),
                        child: const Center(child: Text('Payment Option')),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.05, width: MediaQuery.of(context).size.width*0.15,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: Center(child: Text("N "+cartC.totalAmount.toString())),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn()){
                            print('user logged in');
                          if(Get.find<LocationController>().addressList.isEmpty){
                            // Get.toNamed(RouteHelper.getAddressPage());
                            MakePayment(ctx: context, email: 'userC.userModel.email', price: cartC.totalAmount).chargeCard();
                          }else{
                            Get.offNamed(RouteHelper.getInitial());
                          }
                          cartC.addCartHistory();
                          }
                          else {
                            Get.toNamed(RouteHelper.getLogInPage());
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only( bottom: size.width * 0.04,
                              top: size.width * 0.04,
                              left: size.width*0.05, right: size.width*0.05),
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(13)
                          ),
                          child: const Text('Checkout'),
                        ),
                      )
                    ],
                  )
                ],
              )
                  : Container()
          );
        },
        );
      })
    );
  }
}

