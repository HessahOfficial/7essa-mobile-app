import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryScreen extends StatelessWidget {
  final List<dynamic> images;
  final int initialIndex;

  const GalleryScreen({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: initialIndex);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: images.length,
            scrollPhysics: const BouncingScrollPhysics(),
            pageController: pageController,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(images[index]),
                heroAttributes: PhotoViewHeroAttributes(tag: 'image_$index'),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            backgroundDecoration: const BoxDecoration(color: Colors.black),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => context.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
