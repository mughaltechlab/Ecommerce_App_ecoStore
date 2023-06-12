import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../util/styles.dart';

class HomeImagesSlider extends StatelessWidget {
  const HomeImagesSlider({
    super.key,
    required this.images,
  });

  final List images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: images
            .map((e) => Builder(
                builder: ((context) => Stack(
                      children: [
                        // slider images
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              e,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        // making container for looking better because network images take some time to load....
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.lightBlueAccent.withOpacity(0.3),
                                  Colors.redAccent.withOpacity(0.3),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        // -----------
                        // for title/sale/discount label like..
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black.withOpacity(.4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'TITLE',
                                style: MyStyle.boldstyle.copyWith(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))))
            .toList(),
        options: CarouselOptions(
          height: 200,
          autoPlay: true,
        ));
  }
}
