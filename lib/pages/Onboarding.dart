import 'package:flutter/material.dart';
import 'package:enebla_new/theme/style.dart' as style;
import 'package:shared_preferences/shared_preferences.dart';

class OnBording extends StatefulWidget {
  const OnBording({Key? key}) : super(key: key);

  @override
  State<OnBording> createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording> {
  late PageController _pageController;
  int _pageIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnBoardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("OnBording", isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: demo_data.length,
                  controller: _pageController,
                  onPageChanged: (index) async {
                    await _storeOnBoardInfo();
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnboardContent(
                    image: demo_data[index].image,
                    title: demo_data[index].title,
                    description: demo_data[index].description,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                      demo_data.length,
                      (index) => Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: DotIndicator(isActive: index == _pageIndex),
                          )),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        await _storeOnBoardInfo();
                        // _pageIndex != 3
                        //     ? _pageController.nextPage(
                        //         duration: Duration(milliseconds: 300),
                        //         curve: Curves.ease)
                        //     : Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => LoginPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                      ),
                      child: Icon(Icons.arrow_forward),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: isActive ? 12 : 4,
      width: 6,
      decoration: BoxDecoration(
          color: isActive
              ? style.Style.primaryColor
              : style.Style.navBarSecondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}

class Onboard {
  final String image, title, description;
  Onboard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<Onboard> demo_data = [
  Onboard(
    image: "lib/assets/logo1.png",
    title: " Enebla ",
    description: " Version 1.0.0",
  ),
  Onboard(
    image: "lib/assets/home.png",
    title: "All your favorites",
    description:
        "Order from the best local restaurants with easy, on-demand delivery.",
  ),
  Onboard(
    image: "lib/assets/home.png",
    title: "Affordable Subscription offers",
    description:
        "Affordable Subscription offers for customers via Yene Pay and others payment methods.",
  ),
  Onboard(
    image: "lib/assets/home.png",
    title: "Choose your food",
    description:
        "Easily find your type of food craving and you’ll get delivery in wide range.",
  ),
];

class OnboardContent extends StatelessWidget {
  const OnboardContent(
      {Key? key,
      required this.image,
      required this.title,
      required this.description})
      : super(key: key);

  final String image, title, description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              image,
              width: MediaQuery.of(context).size.width,
              height: 300,
            ),
            const Spacer(),
            // Text(
            //   "Enebla",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //       fontSize: 25,
            //       fontWeight: FontWeight.bold,
            //       color: style.Style.primaryColor),
            // ),
            const Spacer(),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: style.Style.primaryColor),
            ),
            const SizedBox(
              height: 10,
            ),
            const Spacer(),
            Text(
              description,
              textAlign: TextAlign.center,
              // style: TextStyle(
              //     fontSize: 25,
              //     fontWeight: FontWeight.bold,
              //     color: style.Style.primaryColor),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
