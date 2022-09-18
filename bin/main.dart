import 'assets/gauss_controller.dart';
import 'modules/matrix.dart';
import 'extensions/list_extension.dart';

class Epsilon {
  // ignore: constant_identifier_names
  static const NUM_FRACTION = 6;
}

void main() {
  Matrix matrix = Matrix.createGrid();
  matrix.grid.printGrid(
    message: 'Исходная матрица, полученная из СЛАУ:',
  );

  final gaussController = GaussController(
    matrix: matrix,
  );

  gaussController.convertToTriangleView();

  gaussController.grid.printGrid(
    message: 'Приведенная к треугольному виду матрица:',
  );

  gaussController.printResult();
}
