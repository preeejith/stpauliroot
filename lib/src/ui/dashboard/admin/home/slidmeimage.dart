import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselDemo extends StatelessWidget {
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();
  final List<String> imagePaths = [
    'assets/new/admin/admincard1.png',
    'assets/new/admin/admincard2.png',
    'assets/new/admin/admincard3.png',
    'assets/new/admin/admincard5.png'
  ];

  CarouselDemo({super.key});
  @override
  Widget build(BuildContext context) => Column(children: <Widget>[
        CarouselSlider(
          // items: child,

          items: imagePaths.map((path) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(path,
                  fit: BoxFit.cover, width: 1000), // Use Image.asset
            );
          }).toList(),
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            aspectRatio: 2.0,
            initialPage: 2,
          ),
        ),
        MaterialButton(
          onPressed: () => buttonCarouselController.nextPage(
              duration: Duration(milliseconds: 300), curve: Curves.linear),
          child: Text('→'),
        )
      ]);
}
