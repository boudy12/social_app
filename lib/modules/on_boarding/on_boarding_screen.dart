import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/modules/social_app/login/login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/styles/colors.dart';
class BoardingModel{
  final String title;
  final String image;
  final String body;

   BoardingModel({
     required this.title,
     required this.image,
     required this.body
  });
  
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  bool isLast = false;

  List<BoardingModel> boardingModel = [
    BoardingModel(
      title: 'Pay better',
      body: 'Speed safely through checkout and plant trees at no extra cost.',
      image: 'assets/Images/shop1.jpg',
    ),
    BoardingModel(
      title: 'Shop better',
      body: 'Discover new arrivals from your favorite stores first',
      image: 'assets/Images/shop.jpg',
    ),
    BoardingModel(
      title: 'Track better',
      body: 'Get real-time delivery updates from cart to home in one place',
      image: 'assets/Images/shop5.jpg',
    ),
  ];

  void submit(){
    CacheHelper.saveData(
        key: 'onBoarding',
        value: true
    ).then((value) {
      if(value){
        navigateAndFinishSS(context, SocialAppLoginScreen());
      }
    });
  }
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: const Text(
                'SKIP',
                style: TextStyle(
                  fontSize: 18
                ),
              )
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => buildOnBoarding(boardingModel[index]),
                itemCount: 3,
                onPageChanged: (int index){
                  if(index == boardingModel.length -1 )
                    {
                      setState(() {
                        isLast = true;
                      });
                    }
                  else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                controller: pageController,

              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boardingModel.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.blueGrey,
                    dotWidth: 10,
                    expansionFactor: 4,
                    dotHeight: 10,
                    spacing: 5,
                    activeDotColor: defaultColor,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast)
                      {
                        submit();
                      }
                    else{
                      pageController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.bounceOut,
                      );
                    }

                  },
                  child: const Icon(
                      Icons.arrow_forward_ios_outlined
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildOnBoarding(BoardingModel model)=>  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage(
            model.image,
          ),
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        model.title,
        style: const TextStyle(
            fontSize: 25
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        model.body,
        style: const TextStyle(
            fontSize: 16
        ),
      ),
    ],
  );
}

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}
