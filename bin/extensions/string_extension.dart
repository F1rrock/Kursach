import 'dart:convert';
import 'dart:io';

extension Parsing on String {
  int parseStringToInt({String onErrorMessage = ''}) {
    int? element = 0;
    do {
      if (element == null) {
        print(onErrorMessage);
      }
      element = int.tryParse(
        stdin.readLineSync(
          encoding: utf8,
        )!,
      );
    } while (element == null);
    return element;
  }

  double parseStringToFloat({String onErrorMessage = ''}) {
    double? element = 0;
    do {
      if (element == null) {
        print(onErrorMessage);
      }
      var input = stdin.readLineSync(
        encoding: utf8,
      )?.replaceAll(
        ',',
        '.',
      );
      element = double.tryParse(
        input!
      );
    } while (element == null);
    return element;
  }

  bool parseStringToBool({String onErrorMessage = ''}) {
    bool? element = true;
    const map = <String, bool>{
      '0': false,
      '1': true,
    };
    do {
      if (element == null) {
        print(onErrorMessage);
      }
      var input = stdin.readLineSync(
        encoding: utf8,
      );
      element = map[input];
    } while (element == null);
    return element;
  }
}