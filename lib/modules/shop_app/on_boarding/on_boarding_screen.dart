import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/styles/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'on board 1 title',
      body: 'on board 1 body',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'on board 2 title',
      body: 'on board 2 body',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'on board 3 title',
      body: 'on board 3 body',
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed:submit,
              child: Text('SKIP'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value)
      {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });

  }

  Widget buildBoardItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                '${model.image}',
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      );
}
