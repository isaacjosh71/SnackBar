
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:snack_bar/screens/root_app.dart';
import '../../helpers/picker.dart';

class MostPopular extends StatefulWidget {
  const MostPopular({Key? key}) : super(key: key);

  @override
  State<MostPopular> createState() => _MostPopularState();
}

class _MostPopularState extends State<MostPopular> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 60,
            elevation:3,
            leading: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white70,
                  size: 24,
                ),
                onPressed: () {
                  Get.to(()=> const RootApp());
                },),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.white60,
                  child: IconButton(
                    icon: Badge(
                        child: const Icon(
                          Icons.add_shopping_cart_rounded,
                          color: Color(0xFF2B3849),
                          size: 24,
                        ),
                        badgeContent: const Text(
                          '2',
                          style: TextStyle(color: Color(0xFFFFFFFF),
                          ),)),
                    onPressed: () {
                      Navigator.pushNamed(context, "/checkout");
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: size.height*0.002, width: size.width * 0.3,
                        color: Colors.grey,
                      ),
                    ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Text(
                    "name",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        color: Color(0xFF2B3849),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "tags",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xFF55606D),
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.1,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.alarm, size: 17),
                            SizedBox(
                              width: 0.5,
                            ),
                            Text(
                              "delivery_time",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.1,
                        ),
                        IconButton(onPressed: (){},
                            icon: const Icon(Icons.favorite,
                              color: Colors.grey,)),
                      ],
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Close",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xFF2ecc71),
                      fontSize: 15,
                    ),
            ),
  ]
            ),
              ),
    ),
            pinned: true,
            backgroundColor: Colors.orangeAccent,
            stretch: true,
            expandedHeight: size.height * 0.43,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                getImageNetwork("image"),
                width: double.maxFinite,
                fit: BoxFit.fill,
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
                children: const [
                  Text('INTRODUCE',
                  style: TextStyle(
                    color: Color(0xFF455A64),
                    fontSize: 15,
                    letterSpacing: 1.5
                  ),),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "intro",
                    textAlign: TextAlign.justify,
                    maxLines: 60,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Color(0xFF455A64),
                        fontSize: 14.5,
                        fontWeight: FontWeight.w100,
                        wordSpacing: 6
                    ),
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
              child: const Text('N500 | Add to cart'),
            )
          ],
        ),
      ),
    );
  }
}
