import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:magic_backend/config/mongo-client.dart';

// main entry point
// mongo client
final mongoClient = MongoClient();

// Function to run our HTTP server
Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  await mongoClient.connect();
  return serve(handler.use(databaseHandler()), ip, port);
}

// handling the request for our database by reading it's context
Middleware databaseHandler() {
  return (handler) {
    return handler.use(
      provider<MongoClient>(
        (context) => mongoClient,
      ),
    );
  };
}
