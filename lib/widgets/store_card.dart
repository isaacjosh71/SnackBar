

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snack_bar/helpers/app_const.dart';
import 'package:snack_bar/models/product_model.dart';
import 'package:snack_bar/screens/Home/most_popular.dart';
import '../data/controllers/most_popular_ctlr.dart';
import '../helpers/router.dart';

class StoreCard extends StatefulWidget {


   const StoreCard({
    Key? key,
  }) : super(key: key);

  @override
  State<StoreCard> createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  PageController pageController = PageController(viewportFraction: 0.9);
  var _currentPage = 0.0;
  final double _scaleFactor = 0.8;

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState((){
        _currentPage = pageController.page!;
      });
    });
  }

  @override
  void dispose(){
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height * 0.329;
    return GetBuilder<MostPopularController>(builder: (mostPopularC){
      return mostPopularC.isLoaded?
      SizedBox(
        height: _height,
        child: GestureDetector(
          onTap: (){
            Get.toNamed(RouteHelper.getMostPopular());
          },
          child: PageView.builder(
            controller: pageController,
            itemCount: mostPopularC.mostPopularList.length,
            itemBuilder: (BuildContext context, position) {
              return _buildStoreCard(position, mostPopularC.mostPopularList[position]);
            },
          ),
        ),
      )
          :Center(child: CircularProgressIndicator(
        color: Colors.amber.shade100,
      ));
    });
  }

  Widget _buildStoreCard(int index, ProductModel mostPopularC){
    var _height = MediaQuery.of(context).size.height * 0.329;
    Matrix4 matrix4 = Matrix4.identity();
    if(index==_currentPage.floor()){
      var currentScale = 1-(_currentPage-index)*(1-_scaleFactor);
      var currentTransform = _height*(1-currentScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTransform, 0);
    }else if(
    index==_currentPage.floor()+1){
      var currentScale = _scaleFactor+(_currentPage-index+1)*(1-_scaleFactor);
      var currentTransform = _height*(1-currentScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTransform, 0);
    }else if(
    index==_currentPage.floor()-1){
      var currentScale = 1-(_currentPage-index)*(1-_scaleFactor);
      var currentTransform = _height*(1-currentScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTransform, 0);
    }else {
      var currentScale =0.8;
      matrix4 = Matrix4.diagonal3Values(0, currentScale, 0)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }
    return Transform(
      transform: matrix4,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.21,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Image.network(
                      AppConstants.BASE_URL+"/uploads/"+mostPopularC.img!,
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mostPopularC.name!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Color(0xFF2B3849),
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    mostPopularC.location!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF55606D),
                      fontSize:13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(Icons.alarm, size: 17),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '9:00am - 6:00pm',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}