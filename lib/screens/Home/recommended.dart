
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snack_bar/helpers/app_const.dart';
import 'package:snack_bar/helpers/router.dart';
import '../../data/controllers/recommended_ctlr.dart';
import '../../widgets/expandable_text.dart';

class Recommended extends StatefulWidget {
  int pageId;
  Recommended({Key? key, required this.pageId}) : super(key: key);

  @override
  State<Recommended> createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  @override
  Widget build(BuildContext context) {
    var productDetail = Get.find<RecommendedController>().recommendedList[widget.pageId];
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 60,
            elevation:3,
            leading: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {
                  Get.toNamed(RouteHelper.getInitial());
                },),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.white60,
                  child: IconButton(
                    icon: const Icon(
                      Icons.add_shopping_cart_rounded,
                      color: Color(0xFF2B3849),
                      size: 24,
                    ),
                    onPressed: () {
                      
                    },),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                padding:  EdgeInsets.only(
                    left: size.width*0.045,
                    right: size.width*0.025,
                    top: size.height*0.015,
                    bottom: size.height*0.005),
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.orangeAccent,
            stretch: true,
            expandedHeight: size.height * 0.43,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL+AppConstants.UPLOAD+productDetail.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(
                left: size.width*0.01,
                right: size.width*0.01,
              ),
              padding: EdgeInsets.only(
                  left: size.width*0.05,
                  right: size.width*0.05,
                  top: size.height*0.015,
                  bottom: size.height*0.005
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: size.height*0.002, width: size.width * 0.3,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          productDetail.name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              color: Color(0xFF2B3849),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              productDetail.location!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xFF55606D),
                                fontSize: 13,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(Icons.alarm, size: 17),
                                SizedBox(
                                  width: 1,
                                ),
                                Text(
                                  "30-45mins",
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            IconButton(onPressed: (){},
                                icon: const Icon(Icons.favorite,
                                  color: Colors.grey,)),
                          ],
                        ),
                      ]
                  ),
                  const SizedBox(height: 7),
                  const Text('INTRODUCE',
                    style: TextStyle(
                        color: Color(0xFF455A64),
                        fontSize: 15,
                        letterSpacing: 1.5
                    ),),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: ExpandableText(
                        text: productDetail.description!),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: size.height * 0.1,
        padding: EdgeInsets.only( left: size.width * 0.085,
            right: size.width * 0.10),
        decoration: BoxDecoration(
          color: const Color(0xFFE6E9ED).withOpacity(0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  IconButton(onPressed: (){},
                      icon: const Icon(Icons.remove,size: 17,
                        color: Colors.black87,)),
                  const SizedBox(width: 3,),
                  const Text('0'),
                  const SizedBox(width: 3,),
                  IconButton(onPressed: (){},
                      icon: const Icon(Icons.add,size: 17,
                        color: Colors.black87,)),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              padding: EdgeInsets.only( bottom: size.width * 0.04,
                  top: size.width * 0.04,
                  left: size.width*0.05, right: size.width*0.05),
              decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  borderRadius: BorderRadius.circular(13)
              ),
              child: Text('N${productDetail.price}|Add to cart'),
            )
          ],
        ),
      ),
    );
  }
}