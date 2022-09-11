import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snack_bar/data/controllers/cart_contoller.dart';
import 'package:snack_bar/helpers/app_const.dart';
import 'package:snack_bar/screens/Home/root_app.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {Get.to(()=>RootApp());},),
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
          Positioned(
              top: size.height*0.15,
              left: size.width*0.05,
              right: size.width*0.05,
              bottom: 0,
              child: MediaQuery.removePadding(
                context: context,
                  removeTop: true,
                child: GetBuilder<CartController>(builder: (cartC){
                  return ListView.builder(
                      itemCount: cartC.getItems.length,
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
                                Container(
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
                                          height: size.height*0.01,
                                        ),
                                        Text('',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.blue),
                                        ),
                                        SizedBox(
                                          height: size.height*0.015,
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(cartC.getItems[index].price.toString(),
                                                style: TextStyle(color: Colors.blue),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white.withOpacity(0.7),
                                                  borderRadius: BorderRadius.circular(7),
                                                ),
                                                child: Row(
                                                  children: [
                                                    IconButton(onPressed: (){
                                                      // mostPopularC.setQuantity(false);
                                                    },
                                                        icon: const Icon(Icons.remove,size: 17,
                                                          color: Colors.black87,)),
                                                    const SizedBox(width: 3,),
                                                    // Text(mostPopularC.inCartItems.toString()),
                                                    const SizedBox(width: 3,),
                                                    IconButton(onPressed: (){
                                                      // mostPopularC.setQuantity(true);
                                                    },
                                                        icon: const Icon(Icons.add,size: 17,
                                                          color: Colors.black87,)),
                                                  ],
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
        ],
      ),
    );
  }
}
