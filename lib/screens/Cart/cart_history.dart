
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:snack_bar/data/controllers/cart_contoller.dart';
import 'package:snack_bar/helpers/cart_foundation.dart';
import 'package:snack_bar/helpers/app_const.dart';
import 'package:snack_bar/helpers/router.dart';
import 'package:snack_bar/models/cart_model.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().
    getCartHistoryList().reversed.toList();
    //sorting out cart history based on time per order
    Map<String, int> cartItemsPerOrder = Map();
    //just like continual entries for maps
    for(int i=0; i<getCartHistoryList.length; i++){
      //if identical time found, put
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].timeCreated)){
        cartItemsPerOrder.update(getCartHistoryList[i].timeCreated!, (value) =>++value);
      }else{
        //if non identical time found, then put
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].timeCreated!, ()=>1);
      }
    }

    List<String> cartItemsTimeToList(){
      //convert to list entries
      return cartItemsPerOrder.entries.map((e) => e.key).toList();//String takes a key
    }

    List<int> cartItemsPerOrderToList(){
      //convert to list entries
      return cartItemsPerOrder.entries.map((e) => e.value).toList();//
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();//3, 2, 3, 1...

    var listCounter = 0;
    var size =MediaQuery.of(context).size;
    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
      if(index<getCartHistoryList.length){
        //parsing date time object format of original time format from backend
        DateTime parsedDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(getCartHistoryList[listCounter].timeCreated!);
        //convert to string to be used in Text format
        var inputDate = DateTime.parse(parsedDate.toString());
        //convert to date time format needed to be displayed of preferred choice
        var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
        outputDate = outputFormat.format(inputDate);
      }
      return Text(outputDate, style: const TextStyle(fontWeight: FontWeight.w200, color: Colors.black87, fontSize: 17),);
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orangeAccent,
        title:  const Text('Your Cart History',
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.shopping_cart_checkout_rounded, color: Colors.white,size: 25,),
          )
        ],
      ),
      body: GetBuilder<CartController>(builder: (_cartC){
        return _cartC.getCartHistoryList().isNotEmpty
            ? Container(
          height: MediaQuery.of(context).size.height*1,
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width*0.04,
              right: MediaQuery.of(context).size.width*0.04,
              top: MediaQuery.of(context).size.height*0.02
          ),
            child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
             child: ListView(
              children: [
                for (int i=0; i<itemsPerOrder.length; i++)
                  Column(
                      children: [
                        Container(
                          height: size.height*0.15,
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height*0.002),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              timeWidget(listCounter),
                              const SizedBox(height: 10,),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(itemsPerOrder[i], (index){
                                        if(listCounter<getCartHistoryList.length){
                                          listCounter++;
                                        }
                                        return index<=2 ? Container(
                                          height: size.height*0.085, width: size.width*0.185,
                                          margin: const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    AppConstants.BASE_URL+AppConstants.UPLOAD+getCartHistoryList[listCounter-1].img!,
                                                  )
                                              )
                                          ),
                                        ) : Container();
                                      }),
                                    ),
                                    SizedBox(
                                      height: size.height*0.1,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          const Text('Total', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300,
                                              color: Colors.black87),),
                                          Text(itemsPerOrder[i].toString()+' Items',
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300,
                                                  color: Colors.black87)),
                                          InkWell(
                                            onTap: (){
                                              var orderTime = cartItemsTimeToList();
                                              Map<int, CartModel> reOrder = {};
                                              for (int j=0; j<getCartHistoryList.length; j++){
                                                if(getCartHistoryList[j].timeCreated==orderTime[i]){
                                                  reOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                      CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j]))));
                                                }
                                              }
                                              Get.find<CartController>().setItems = reOrder;
                                              Get.find<CartController>().addToCartListReorder();
                                              Get.toNamed(RouteHelper.getCartPage());
                                            },
                                            child: Container(
                                              height: 25,width: 75,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(color: Colors.orangeAccent, width: 1.5),
                                              ),
                                              child: const Center(child: Text('Reorder')),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ]
                              )
                            ],
                          ),
                        ),
                        Container(height: 0.3, decoration: const BoxDecoration(
                            color: Colors.black54
                        ),),
                        SizedBox(height: size.height*0.02,)
                      ]
                  ),
              ],
            ),
          ),
        )
            : const CartFoundation(text: 'You didn\'t buy anything so far');
      },)
    );
  }
}
