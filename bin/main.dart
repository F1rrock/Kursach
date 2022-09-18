import 'modules/matrix.dart';

import 'package:dolumns/dolumns.dart';

void main() {
  Matrix matrix = Matrix.createGrid(
    isRandomFilled: true,
  );
  print(dolumnify(
    matrix.grid,
    columnSplitter: ' | ',
  ));
}
