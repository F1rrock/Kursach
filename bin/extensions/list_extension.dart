import 'package:dolumns/dolumns.dart';

extension Print<T extends Object> on List<List<T>> {
  void printGrid({
    String message = '',
    int fraction = 6,
  }) {
    final border = '=' * length * 5;
    print('\n$message');
    print(dolumnify(
      this,
      columnSplitter: ' | ',
      fraction: fraction + 2,
    ));
    print(border);
  }
}
