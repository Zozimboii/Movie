import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../theme/theme_provider.dart';
import 'package:provider/provider.dart';
import '../model/movie.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference movies = FirebaseFirestore.instance.collection(
      'Movies',
    );
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Movies List',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            CupertinoSwitch(
              value:
                  Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
              onChanged:
                  (value) =>
                      Provider.of<ThemeProvider>(
                        context,
                        listen: false,
                      ).toggleTheme(),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: movies.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return ListView(
            children:
                snapshot.data!.docs.map((movie) {
                  return ListTile(
                    title: Text(
                      movie['MovieName'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.inversePrimary, 
                      ),
                    ),
                    subtitle: Text(
                      '${movie['Duration']} min',
                      style: TextStyle(
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.inversePrimary, 
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.green),
                          onPressed:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => EditMoviePage(
                                        movie.id,
                                        movie['MovieName'],
                                        movie['Categories'],
                                        movie['Duration'],
                                      ),
                                ),
                              ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => movies.doc(movie.id).delete(),
                        ),
                      ],
                    ),
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => EditMoviePage(
                                  movie.id,
                                  movie['MovieName'],
                                  movie['Categories'],
                                  movie['Duration'],
                                ),
                          ),
                        ),
                  );
                }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddMoviePage()),
            ),
      ),
    );
  }
}
