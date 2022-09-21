import 'assets/matrix_methods_controller.dart';
import 'extensions/string_extension.dart';
import 'modules/matrix.dart';
import 'modules/matrix_controller.dart';

void main() {
  Matrix matrix = Matrix.createGrid(
    isRandomFilled: true,
  );

  print('Введите допустимую погрешность для будущих корней:');
  var str = '';

  final matrixController = MatrixController(
    matrix: matrix,
    epsilon: str.parseStringToFloat(
      onErrorMessage: 'неверный формат погрешности',
    ),
  );

  final methodController = MatrixMethodsController(
    matrixController: matrixController,
  );

    methodController.executeGauss();

    //methodController.
}
