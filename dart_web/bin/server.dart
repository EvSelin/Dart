import 'dart:convert';
import 'dart:io';
import 'dart:async';

Future main() async {
  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    4040,
  );
  print('Listening on localhost:${server.port}');
  
  await for (HttpRequest request in server) {
      handleRequest(request);
    }
}


void handleRequest(HttpRequest request) {
  try {
    if (request.method == 'GET') {
      handleGet(request);
    } else {
    
    }
    
    if(request.method == 'POST') {
      handlePost(request);
    } else {
    
    }
  } catch (e) {
    print('Exception in handleRequest: $e');
  }
  print('Request handled.');
}

handleGet(request) {
  
  request.response
    ..write('Hello, world!')
    ..close();
}

handlePost(req) async {
    var content = await req.transform(Utf8Decoder()).join();
    print(content);
    var queryParams = Uri(query: content).queryParameters;
    req.response
      ..write('Parsed data belonging to ${queryParams['name']}')
      ..close();
}