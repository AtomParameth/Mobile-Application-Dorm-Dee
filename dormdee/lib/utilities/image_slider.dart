import 'package:dormdee/controllers/dorm_controller.dart';
import 'package:dormdee/pages/dorm_info_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  CarouselController controller = CarouselController();
  int currentPageIndex = 0;
  final dormController = Get.put(DormController());
  @override
  void initState() {
    controller = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DormInfoPage(
              dorm: dormController.topRatedDorms[currentPageIndex],
              dormId: dormController.topRatedDorms[currentPageIndex].id,
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            carouselController: controller,
            items: [0, 1, 2, 3, 4].map((i) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Obx(() {
                    if (DormController.instance.topRatedDorms.isNotEmpty) {
                      return Image.network(
                        DormController.instance.topRatedDorms[i].imageUrl,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return const Text("No top rated dorms");
                    }
                  }),
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
      ),
    );
  }
}
