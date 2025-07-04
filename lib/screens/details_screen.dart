import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final String name;
  final String image;
  final String origin;
  final String temperament;
  final String description;
  const DetailsScreen({
    super.key,
    required this.name,
    required this.image,
    required this.origin,
    required this.temperament,
    required this.description,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(
      context,
    ).textTheme.apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name, style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
        backgroundColor: Color(0xFF8C8C8C),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Color(0xFFD9D9D9),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(child: Image.network(widget.image, fit: BoxFit.cover)),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        "About me: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      Text(widget.description, style: textTheme.bodyLarge),
                      SizedBox(height: 12),
                      Text(widget.description, style: textTheme.bodyLarge),
                      SizedBox(height: 12),
                      Text(widget.description, style: textTheme.bodyLarge),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          children: [
                            Text(
                              "Origin: ${widget.origin}",
                              style: textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Temperament: ${widget.temperament}",
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
