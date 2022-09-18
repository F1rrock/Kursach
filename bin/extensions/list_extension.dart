import 'package:dolumns/dolumns.dart';

extension Print<T extends num> on List<List<T>> {
  void printGrid({String message = ''}) {
    final border = '=' * length * 5;
    print('\n$message');
    print(dolumnify(
      this,
      columnSplitter: ' | ',
    ));
    print('$border\n');
  }
}
