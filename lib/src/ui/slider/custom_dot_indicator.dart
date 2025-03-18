import 'package:flutter/material.dart';
import 'package:iroots/src/utility/const.dart';

class CustomPageViewIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final double indicatorSize;

  const CustomPageViewIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
    required this.indicatorSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(itemCount, (index) {
          return Center(
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: index == currentIndex
                      ? Colors.white
                      : ConstClass.unselectedColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  border: Border.all(
                    width: 0,
                    color: Colors.white,
                    style: BorderStyle.solid,
                  ),
                )),
          );
        }));
  }
}
