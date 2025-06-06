import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/routes/app_routes.dart';

import 'package:hessa/features/property/presentation/managers/slider_cubit.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_fullscreen_image.dart';

class CustomImageSlider extends StatelessWidget {
  final List<String> images;

  const CustomImageSlider({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<SliderCubit, SliderState>(
      builder: (bccontext, state) {
        int pageIndex = context.read<SliderCubit>().pageIndex;

        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (context, index, realIndex) {
                final image = images[index];
                return CustomFullscreenImage(
                  onTap:
                      () => context.push(
                        AppRoutes.galleryView,
                        extra: {"images": images, "init": pageIndex},
                      ),
                  screenWidth: screenWidth,
                  image: image,
                );
              },
              options: CarouselOptions(
                initialPage: pageIndex,
                autoPlay: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                viewportFraction: 0.75,
                autoPlayInterval: Duration(seconds: 2),
                onPageChanged: (index, reason) {
                  context.read<SliderCubit>().changePageIndex(index: index);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
