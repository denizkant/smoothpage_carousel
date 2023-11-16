import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SmoothPage(),
    );
  }
}

class SmoothPage extends StatefulWidget {
  const SmoothPage({super.key});

  @override
  State<SmoothPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SmoothPage> {
  @override
  int _currentSlide = 0;
  final CarouselController _carouselController = CarouselController();

  List<Item> items = [
    Item('Fast and easy retriveal of messages', 'images/1.jpg',
        ' Working with messages'),
    Item('It became easy to choose and watch video', 'images/2.jpg',
        'Watch the video'),
    Item('Structured data of your statistics', 'images/3.jpg', 'Check stats'),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16) +
            const EdgeInsets.only(top: 16, bottom: 36),
        child: Column(
          children: [
            _widgetCarousel(),
            SizedBox(height: 10),
            Text(
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                (items[_currentSlide].title)),
            SizedBox(
              height: 10,
            ),
            Text(
                textAlign: TextAlign.center,
                items[_currentSlide].explanation,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 30,
                )),
            const Spacer(),
            _widgetSmoothPageAndButton(),
            _currentSlide == 2
                ? FilledButton(
                    onPressed: () {},
                    child: Text(
                      'GET STARTED',
                      style: TextStyle(fontSize: 20),
                    ))
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Row _widgetSmoothPageAndButton() {
    return Row(
      children: [
        _currentSlide != 2
            ? AnimatedSmoothIndicator(
                activeIndex: _currentSlide,
                count: 3,
                effect: WormEffect(),
                onDotClicked: (index) {
                  setState(() {
                    _currentSlide = index;
                  });
                })
            : SizedBox(),
        const Spacer(),
        _currentSlide != 2
            ? TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                onPressed: _currentSlide == 2
                    ? null
                    : () {
                        _carouselController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                      },
                child: Text('SKIP'),
              )
            : SizedBox(),
      ],
    );
  }

  CarouselSlider _widgetCarousel() {
    return CarouselSlider(
      carouselController: _carouselController,
      options: CarouselOptions(
        height: 400.0,
        enableInfiniteScroll: false,
        initialPage: _currentSlide,
        viewportFraction: 1.0,
        onPageChanged: (index, reason) {
          setState(() {
            _currentSlide = index;
          });
        },
      ),
      items: items.map((item) {
        return Image.asset(
          item.image,
          width: double.infinity,
          fit: BoxFit.cover,
        );
      }).toList(),
    );
  }
}

class Item {
  final String title;
  final String image;
  final String explanation;

  Item(this.explanation, this.image, this.title);
}
