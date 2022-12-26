import 'package:ary_bol_geo/add/add_news.dart';
import 'package:ary_bol_geo/update/edit_news.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class DisplayDelete extends StatefulWidget {
  const DisplayDelete({super.key});

  @override
  State<DisplayDelete> createState() => _DisplayDeleteState();
}

class _DisplayDeleteState extends State<DisplayDelete> {
  // variables
  final dbShowRefrence = FirebaseDatabase.instance.ref('News');
  DatabaseReference ref = FirebaseDatabase.instance.ref('News');
  //controllers
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Display Delete Page'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.logout_rounded),
            ),
          ]),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 05),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Search',
                hintText: 'Search News',
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FirebaseAnimatedList(
                  query: dbShowRefrence,
                  itemBuilder: (context, snapshot, animation, index) {
                    final title = snapshot.child('title').value.toString();
                    final news = snapshot.child('news').value.toString();
                    final id = snapshot.child('id').value.toString();
                    if (searchController.text.isEmpty) {
                      return Card(
                        child: ListTile(
                          onLongPress: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditNews(title, news, id),
                              ),
                            );
                          },
                          title: Text(
                            snapshot.child('title').value.toString(),
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            snapshot.child('news').value.toString(),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              ref
                                  .child(snapshot.child('id').value.toString())
                                  .remove();
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          leading: const CircleAvatar(
                            child: Icon(Icons.newspaper_rounded),
                          ),
                        ),
                      );
                    } else if (title
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase())) {
                      return Card(
                        child: ListTile(
                          onLongPress: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditNews(title, news, id),
                              ),
                            );
                          },
                          title: Text(
                            snapshot.child('title').value.toString(),
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            snapshot.child('news').value.toString(),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              ref
                                  .child(snapshot.child('id').value.toString())
                                  .remove();
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          leading: const CircleAvatar(
                            child: Icon(Icons.newspaper_rounded),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNews(),
            ),
          );
        },
        label: const Text('Add Data'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
