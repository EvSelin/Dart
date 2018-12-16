import 'dart:io';
import 'dart:convert';
import 'dart:async';

void main() {
  final RegExp nameRules = RegExp('[a-zA-Z]');

  Stream<List> inputStream = stdin;

  inputStream
      .transform(utf8.decoder)
      .transform(new LineSplitter())
      .listen((String line) {
          reedFile();
          if (line.length > 1 && line.length < 20) {
              if (nameRules.hasMatch(line)) {
                  writeFile(line);
              } else {
                  print('use latin');
              }
          } else {
              print('wrong lenght');
          }
      }, onDone: () {
      }, onError: (e) {
      	    print(e.toString());
      });
}

createFile() {
    new File('file.txt')
        .create(recursive: true)
        .then((file) {
            print(file.path);
        });
}

reedFile() async  {
	int price = 0;
	Stream lines = new File('file.txt')
        .openRead()
        .transform(utf8.decoder)
        .transform(new LineSplitter());
    
	try {
		await for (var line in lines) {
			line.contains('+one') ? price += 200 : price += 100;
		}
	} catch (_) {
		print(_);
	}
	
	print(price);
}

Future writeFile(content) async {
    await new File('file.txt')
        .writeAsString(content + '\n', mode: FileMode.APPEND);
}