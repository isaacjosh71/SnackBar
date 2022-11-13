
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:snack_bar/data/controllers/cart_contoller.dart';
import 'package:snack_bar/helpers/app_const.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList();
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

    List<int> cartOrderTimeToList(){
      //convert to list entries
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemsPerOrder = cartOrderTimeToList();

    // var saveCounter = 0;
    // for(int x=0; x<cartItemsPerOrder.length; x++){
    //   for(int y=0; y<orderTimes.length; y++){
    //
    //   }
    // }
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
      body: Container(
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width*0.055,
            right: MediaQuery.of(context).size.width*0.055,
            top: MediaQuery.of(context).size.height*0.035
        ),
        child: ListView(
          children: [
            for (int i=0; i<itemsPerOrder.length; i++)
              Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height*0.035),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date'),
                      Wrap(
                        direction: Axis.horizontal,
                          children: List.generate(itemsPerOrder[i], (index)
                          {
                           return Container(
                             height: 80, width: 80,
                             decoration: BoxDecoration(
                               image: DecorationImage(
                                 image: NetworkImage(
                                   AppConstants.BASE_URL+AppConstants.UPLOAD+getCartHistoryList[i].img!,
                                 )
                               )
                             ),
                           );
                          }),
                      )
                    ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
