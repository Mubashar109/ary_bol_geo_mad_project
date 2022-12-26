import 'package:ary_bol_geo/display/display_delete.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class EditNews extends StatefulWidget {
  final String title;
  final String news;
  final String id;
  const EditNews(this.title, this.news, this.id, {super.key});

  @override
  State<EditNews> createState() => _EditNewsState();
}

class _EditNewsState extends State<EditNews> {
  //form key
  final formkey = GlobalKey<FormState>();
  //controllers
  final titleController = TextEditingController();
  final newsController = TextEditingController();
  //id
  String? id;
  // variables
  final dbShowRefrence = FirebaseDatabase.instance.ref('News');
  DatabaseReference ref = FirebaseDatabase.instance.ref('News');

  @override
  void initState() {
    titleController.text = widget.title;
    newsController.text = widget.news;
    id = widget.id;
    super.initState();
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
                      maxLines: 2,
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
                    ref.child(id!).update({
                      'title': titleController.text.toString(),
                      'news': newsController.text.toString(),
                    });
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
