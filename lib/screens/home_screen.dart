import 'package:flutter/material.dart';
import 'package:flutter_cat_app/components/cat_card.dart';
import 'package:flutter_cat_app/models/cat_app_model.dart';
import 'package:flutter_cat_app/services/cat_app_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String searchValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catbreeds', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Color(0xFF8C8C8C),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFD9D9D9),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 24.0,
              right: 24.0,
            ),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search by name",
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF3399CC)),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchValue = value;
                  });
                },
              ),
            ),
          ),
          bodyList(),
        ],
      ),
    );
  }

  FutureBuilder<List<CatAppModel>> bodyList() {
    return FutureBuilder(
      future: fetchCats(searchValue),
      builder: (context, AsyncSnapshot<List<CatAppModel>> snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapShot.hasError) {
          return Text("Error: ${snapShot.error}");
        } else if (snapShot.hasData) {
          return Expanded(
            child: ListView.builder(
              itemCount: snapShot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CatCard(
                    id: snapShot.data![index].id,
                    name: snapShot.data![index].name,
                    origin: snapShot.data![index].origin,
                    temperament: snapShot.data![index].temperament,
                    description: snapShot.data![index].description,
                  ),
                );
              },
            ),
          );
        } else {
          return Text("There are not results yet");
        }
      },
    );
  }
}
