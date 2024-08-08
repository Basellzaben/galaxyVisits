import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
    final String imgUrl;

  ImageDialog({required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children:[InteractiveViewer(
          boundaryMargin: EdgeInsets.all(double.infinity),
          child:  CachedNetworkImage(
                          imageUrl: imgUrl,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Icon(Icons.error),  // Optional: Error widget when failing to load
            progressIndicatorBuilder: (context, url, downloadProgress) {
              return Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                      
                ),
              );
            },
          ),
        ),] 
      ),
    );
  }
}