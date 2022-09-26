import 'dart:convert';
import 'dart:io';

/// declare extension on any grid
extension Parsing on String {
  /// implement new int parse method
  int parseStringToInt({String onErrorMessage = ''}) {
    /// declaring of future input num
    int? element = 0;

    /// initialize [element] variable until
    /// this can be parsed to int in (UTF-8)
    do {
      /// by default element variable can't be [null]
      /// because it's zero
      if (element == null) {
        /// printing of illustrating error message,
        /// that implements pseudo UI
        print(onErrorMessage);
      }

      /// element will be [int] or [null]
      element = int.tryParse(
        /// read users input
        stdin.readLineSync(
          encoding: utf8,
        )!,
      );
    } while (element == null);
    return element;
  }

  /// implement new int parse method
  double parseStringToFloat({String onErrorMessage = ''}) {
    /// declaring of future input num
    double? element = 0;

    /// initialize [element] variable until
    /// this can be parsed to [int] in (UTF-8)
    do {
      /// by default element variable can't be [null]
      /// because it's zero
      if (element == null) {
        /// printing of illustrating error message,
        /// that implements pseudo UI
        print(onErrorMessage);
      }

      /// read users input with dot replacement
      var input = stdin
          .readLineSync(
            encoding: utf8,
          )
          ?.replaceAll(
            ',',
            '.',
          );

      /// element will be [double] or [null]
      element = double.tryParse(input!);
    } while (element == null);
    return element;
  }

  /// implement new int parse method
  bool parseStringToBool({String onErrorMessage = ''}) {
    /// declaring of future input bool (1; 0)
    bool? element = true;

    /// declare constant [bool] map
    const map = <String, bool>{
      '0': false,
      '1': true,
    };

    /// initialize [element] variable until
    /// this can be parsed to [bool] in (UTF-8)
    do {
      /// by default element variable can't be [null]
      /// because it's true
      if (element == null) {
        /// printing of illustrating error message,
        /// that implements pseudo UI
        print(onErrorMessage);
      }

      /// read users input
      var input = stdin.readLineSync(
        encoding: utf8,
      );

      /// get element from constant [map],
      /// [null] if key not found
      element = map[input];
    } while (element == null);
    return element;
  }
}
