import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMoviePage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final CollectionReference movies = FirebaseFirestore.instance.collection(
    'Movies',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        title: Text(
          'Add Movie',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Movie Name',
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                labelText: 'Category',
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            TextField(
              controller: durationController,
              decoration: InputDecoration(
                labelText: 'Duration (min)',
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                movies.add({
                  'MovieName': nameController.text,
                  'Categories': categoryController.text,
                  'Duration': int.parse(durationController.text),
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                'Add Movie',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditMoviePage extends StatelessWidget {
  final String id;
  final TextEditingController nameController;
  final TextEditingController categoryController;
  final TextEditingController durationController;
  final CollectionReference movies = FirebaseFirestore.instance.collection(
    'Movies',
  );

  EditMoviePage(this.id, String name, String category, int duration)
    : nameController = TextEditingController(text: name),
      categoryController = TextEditingController(text: category),
      durationController = TextEditingController(text: duration.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        title: Text(
          'Edit Movie',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Movie Name',
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                labelText: 'Category',
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            TextField(
              controller: durationController,
              decoration: InputDecoration(
                labelText: 'Duration (min)',
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                movies.doc(id).update({
                  'MovieName': nameController.text,
                  'Categories': categoryController.text,
                  'Duration': int.parse(durationController.text),
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                'Update Movie',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
