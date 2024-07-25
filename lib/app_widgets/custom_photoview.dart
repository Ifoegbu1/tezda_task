import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CustomPhotoView extends StatelessWidget {
  final String photoUrl;
  final String heroTag;
  const CustomPhotoView({
    super.key,
    required this.photoUrl,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Hero(
        tag: heroTag,
        child: PhotoView(
          minScale: PhotoViewComputedScale.contained,
          imageProvider: CachedNetworkImageProvider(photoUrl),
          // errorBuilder: (context, error, stackTrace) => const Center(
          //   child: SizedBox(
          //     height: 200,
          //     child: Icon(Icons.person),
          //   ),
          // ),
        ),
      ),
    );
  }
}
