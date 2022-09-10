
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';
import 'package:snack_bar/helpers/router.dart';
import 'package:snack_bar/screens/Home/most_popular.dart';
import 'package:snack_bar/screens/Home/recommended.dart';
import 'package:snack_bar/screens/Home/snack_categories.dart';
import 'package:snack_bar/widgets/store_card.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snack_bar/helpers/categories.dart';
import 'package:badges/badges.dart';
import '../../widgets/dish_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
      child: AppBar(
        elevation: 0.8,
        backgroundColor: const Color(0xFFFFFFFF),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        automaticallyImplyLeading: false,
        primary: false,
        excludeHeaderSemantics: true,
        flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 20,left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            Image.asset('assets/images/25.png',
                              color: Colors.brown.shade700,
                              height: size.height * 0.03,
                            ),
                            const Text('Snack',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFFFCC4B),
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),),
                            const Text('Bar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),),
                          ]
                      ),
                      IconButton(
                        icon: const Icon( Icons.chat_outlined,
                        color: Color(0xFF2B3849),),
                        onPressed: () {
                          Navigator.pushNamed(context, "/customer_care");
                        },)
                    ],
                  ),
                ],
              ),
            )),
      ),
      ),
      body: getBody(),
    );
  }

  Widget getBody(){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 17, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText(
                          'Welcome Back!',
                          textAlign: TextAlign.justify,
                          textStyle: const TextStyle(
                            color: Color(0xFF455A64),
                          fontSize: 32,
                    )
                          ),
                      ],
                      isRepeatingAnimation: false,
                    ),
                    const Text(
                      'Kindly place an order',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          Center(
            child: TextFieldCase(
              child: Row(
                children: [
                  const Flexible(
                    child: TextField(
                      cursorColor: Colors.black,
                      showCursor: true,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon( Icons.search,
                      color: Colors.orange,),
                    onPressed: () {
                      Navigator.pushNamed(context, "/search_menu");
                    },),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Categories',
                style: TextStyle(
                  fontSize: 23,
                  color: Color(0xFF455A64),
                ),),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(snacks.length, (index)
                      => Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                PageTransition(
                                    alignment: Alignment.bottomCenter,
                                    child: SnackCategories(
                                      snack: snacks[index],
                                    ),
                                    type: PageTransitionType.scale));
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 40,
                                height: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            snacks[index]['img']
                                        ),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(snacks[index]['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.amber.shade400
                                ),),
                            ],
                          ),
                        ),
                      ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Most Popular',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Color(0xFF455A64),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StoreCard(),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Recommended',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Color(0xFF455A64),
                      ),
                    ),
                    DishCard(),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class TextFieldCase extends StatelessWidget {
  final Widget child;
  const TextFieldCase({Key? key,
    required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 310,
      decoration: BoxDecoration(
        color: Colors.white12,
        border: Border.all(
          width: 2,
          color: Colors.black12,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 15, vertical: 2,
      ),
      child: child,
    );
  }
}
