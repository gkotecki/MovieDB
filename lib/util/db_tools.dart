import 'dart:async';

import 'package:myapp/movies/movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> database;

void abreBancoDeDados() async {
  database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'favorite_movies.db'),
    // When the database is first created, create a table to store dogs
    onCreate: (db, version) {
      return db.execute(
        // "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
        "CREATE TABLE movies(id INTEGER PRIMARY KEY, vote_count INTEGER, vote_average TEXT, title TEXT, popularity REAL, poster_path TEXT, original_language TEXT, original_title TEXT, backdrop_path TEXT, overview TEXT, release_date TEXT)",
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );
}

Future<void> insertMovie(Movie movie) async {
  // Get a reference to the database
  final Database db = await database;

  // Insert the Dog into the correct table. We will also specify the
  // `conflictAlgorithm` to use in this case. If the same dog is inserted
  // multiple times, it will replace the previous data.
  await db.insert(
    'movies',
    movie.toJson(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Movie>> movies() async {
  // Get a reference to the database
  final Database db = await database;
  // Query the table for All The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('movies');
  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return Movie(
      id: maps[i]['id'],
      title: maps[i]['title'],
      releaseDate: maps[i]['release_date'],
      voteCount: maps[i]['vote_count'],
      voteAverage: maps[i]['vote_average'].toString(),
      popularity: maps[i]['popularity'],
      posterPath: maps[i]['poster_path'],
      originalLanguage: maps[i]['original_language'],
      originalTitle: maps[i]['original_title'],
      backdropPath: maps[i]['backdrop_path'],
      overview: maps[i]['overview'],
    );
  });
}

Future<void> updateMovie(Movie movie) async {
  // Get a reference to the database
  final db = await database;

  // Update the given Dog
  await db.update(
    'movies',
    movie.toJson(),
    // Ensure we only update the Dog with a matching id
    where: "id = ?",
    // Pass the Dog's id through as a whereArg to prevent SQL injection
    whereArgs: [movie.id],
  );
}

Future<void> deleteMovie(int id) async {
  // Get a reference to the database
  final db = await database;

  // Remove the Dog from the Database
  await db.delete(
    'movies',
    // Use a `where` clause to delete a specific dog
    where: "id = ?",
    // Pass the Dog's id through as a whereArg to prevent SQL injection
    whereArgs: [id],
  );
}

var fido = Movie(
  id: 0,
  title: 'Fido',
  releaseDate: '35',
);

void testeBancoNaoUsar() async {
// Insert a dog into the database
  await insertMovie(fido);

  // Print the list of dogs (only Fido for now)
  print(await movies());

  // Update Fido's age and save it to the database
  fido = Movie(
    id: fido.id,
    title: fido.title,
    releaseDate: '50',
  );
  await updateMovie(fido);

  // Print Fido's updated information
  print(await movies());

  // Delete Fido from the Database
  await deleteMovie(fido.id);

  // Print the list of dogs (empty)
  print(await movies());
}