import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:dormdee/models/dorm_model.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  CarouselController controller = CarouselController();
  int currentPageIndex = 0;
  final DormController dormController = DormController();
  @override
  void initState() {
    controller = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          carouselController: controller,
          items: [1, 2, 3, 4, 5].map((i) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(
                child: Text(
                  'text $i',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            onPageChanged: (index, reason) => setState(() {
              currentPageIndex = index;
            }),
            height: 180,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        DotsIndicator(
          dotsCount: 5,
          position: currentPageIndex.toDouble(),
          onTap: (positons) {
            controller.animateToPage(positons.toInt());
          },
          decorator: DotsDecorator(
              color: Colors.grey,
              activeColor: Colors.black87,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
        ),
      ],
    );
  }
}
