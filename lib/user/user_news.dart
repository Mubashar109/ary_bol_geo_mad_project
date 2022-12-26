import 'package:ary_bol_geo/adminuser/admin_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class UserNews extends StatefulWidget {
  const UserNews({super.key});

  @override
  State<UserNews> createState() => _UserNewsState();
}

class _UserNewsState extends State<UserNews> {
  // variables
  final dbShowRefrence = FirebaseDatabase.instance.ref('News');
  DatabaseReference ref = FirebaseDatabase.instance.ref('News');
  //controllers
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User News'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminUser(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
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
                          title: Text(
                            snapshot.child('title').value.toString(),
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            snapshot.child('news').value.toString(),
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
                          title: Text(
                            snapshot.child('title').value.toString(),
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            snapshot.child('news').value.toString(),
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
    );
  }
}
