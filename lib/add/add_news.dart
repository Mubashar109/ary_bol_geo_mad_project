import 'package:ary_bol_geo/display/display_delete.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddNews extends StatefulWidget {
  const AddNews({super.key});

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  //form key
  final formkey = GlobalKey<FormState>();
  //controllers
  final titleController = TextEditingController();
  final newsController = TextEditingController();
  //random id generation
  String id = DateTime.now().microsecondsSinceEpoch.toString();
  //function to enter
  void svadatabase() {
    final dbRefrence = FirebaseDatabase.instance.ref('News');
    dbRefrence
        .child(id)
        .set({
          'id': id,
          'title': titleController.text.toString(),
          'news': newsController.text.toString(),
        })
        .then((value) {})
        .onError((error, stackTrace) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add News'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const DisplayDelete(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Form(
                key: formkey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'title',
                        hintText: 'Title Of News',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter title of news';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: newsController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'News',
                        hintText: 'Enter News',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter News';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DisplayDelete(),
                        ),
                      );
                    }
                    svadatabase();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("Save News"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
