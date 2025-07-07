import 'package:flutter/material.dart';
import 'package:flutter_cat_app/models/cat_app_model.dart';
import 'package:flutter_cat_app/models/single_cat_model.dart';
import 'package:flutter_cat_app/screens/details_screen.dart';
import 'package:flutter_cat_app/services/single_cat_services.dart';

class CatCard extends StatefulWidget {
  final CatAppModel item;
  const CatCard({
    super.key,
    required this.item,
  });

  @override
  State<CatCard> createState() => _CatCardState();
}

class _CatCardState extends State<CatCard> {
  @override
  Widget build(BuildContext context) {
    List<String> values = widget.item.temperament.split(",");
    final firstAttribute = values[0];
    final TextTheme textTheme = Theme.of(
      context,
    ).textTheme.apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Card(
      color: Color(0xFFBFBFBF),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(widget.item.name, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  )),
                ),
              ],
            ),
            SizedBox(height: 12),
            imageList(widget.item.id),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(widget.item.origin, style: textTheme.bodyLarge),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Text(firstAttribute, style: textTheme.bodyLarge),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<SingleCatModel>> imageList(String id) {
    return FutureBuilder(
      future: fetchCatImage(id),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapShot.hasData) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapShot.data!.length,
            itemBuilder: (context, index) {
              final imageList = snapShot.data![index];
              return GestureDetector(
                onTap: () {
                  final imageUrl = imageList.url;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => DetailsScreen(
                            name: widget.item.name,
                            image: imageUrl,
                            origin: widget.item.origin,
                            temperament: widget.item.temperament,
                            description: widget.item.description,
                          ),
                    ),
                  );
                },
                child: SizedBox(
                  width: 200,
                  height: 300,
                  child: Image.network(
                    snapShot.data![index].url,
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
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
