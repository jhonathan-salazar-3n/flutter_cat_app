import 'package:flutter/material.dart';
import 'package:flutter_cat_app/services/single_cat_services.dart';

class ImageList extends StatefulWidget {
  final String id;
  const ImageList({super.key, required this.id});

  @override
  State<ImageList> createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchCatImage(widget.id),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapShot.data!.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 200,
                height: 300,
                child: Image.network(
                  snapShot.data![index].url,
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              );
            },
          );
        } else {
          return Text("No image available");
        }
      },
    );
  }
}
