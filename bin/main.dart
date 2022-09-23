import 'assets/gauss_controller.dart';
import 'assets/seidel_controller.dart';
import 'extensions/string_extension.dart';
import 'modules/matrix.dart';
import 'modules/matrix_controller.dart';

void main() {
  Matrix matrix = Matrix.createGrid(
    isRandomFilled: true,
  );

  print('Введите допустимую погрешность в интервале (0.1e-7; 1) для будущих корней:');
  var str = '';
  double epsilon;

  do{
    epsilon = str.parseStringToFloat(
      onErrorMessage: 'Неверный формат погрешности, '
          'попробуйте ввести другое значение:',
    );
  } while(epsilon <= 0.0000001 || epsilon >= 1);

  final matrixController = MatrixController(
    matrix: matrix,
    epsilon: epsilon,
  );

  print('Введите 0, если хотите найти корни методом Гаусса, '
      'или же 1, если методом Зейделя:');
  if(str.parseStringToBool(onErrorMessage: 'Неверный формат, введите 0, '
      'если метод Гаусса, или 1, если метод Зейделя:')) {
    //methodController.executeSeidel();
    SeidelController(
      matrixController: matrixController,
    );
  } else {
    //methodController.executeGauss();
    GaussController(
      matrixController: matrixController,
    );
  }
}
