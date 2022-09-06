
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snack_bar/data/controllers/recommended_ctlr.dart';

import '../helpers/app_const.dart';
import '../helpers/router.dart';

class DishCard extends StatelessWidget {

  const DishCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.92,
      child: GetBuilder<RecommendedController>(builder:(recommendedC){
        return recommendedC.isLoaded?
        GestureDetector(
          onTap: (){
            Get.toNamed(RouteHelper.getRecommended());
          },
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedC.recommendedList.length,
              itemBuilder: (context, index){
                return Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.2,
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft:Radius.circular(10),
                                bottomLeft: Radius.circular(10) ),
                            image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: NetworkImage(
                                AppConstants.BASE_URL+"/uploads/"+recommendedC.recommendedList[index].img!,
                              ),
                            )
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              recommendedC.recommendedList[index].name!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Color(0xFF2B3849),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              recommendedC.recommendedList[index].location!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xFF55606D),
                                fontSize:14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
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
                );
              }),
        )
        : Center(
          child: CircularProgressIndicator(
            color: Colors.amber.shade100,
          ),
        );
      }),
    );
  }
}
