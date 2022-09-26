import 'package:dolumns/dolumns.dart';

/// declare extension on any grid
extension Print<T extends Object> on List<List<T>> {
  /// declare method, which will print grid as table
  void printGrid({
    /// declare text of message that will print
    /// before table
    String message = '',

    /// declare variable causes amount of
    /// digits after dot
    int fraction = 6,
  }) {
    /// declare border line in the bottom of table
    final border = '=' * length * 5;

    /// printing of illustrating message,
    /// that implements pseudo UI
    print('\n$message');

    /// printing table
    print(dolumnify(
      this,
      columnSplitter: ' | ',
      fraction: fraction + 2,
    ));

    /// printing bottom border line [border]
    print(border);
  }
}
