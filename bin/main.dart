import 'assets/gauss_controller.dart';
import 'assets/seidel_controller.dart';

import 'extensions/string_extension.dart';

import 'modules/matrix.dart';
import 'modules/matrix_controller.dart';


/// application runs here
void main() {
  /// create an object of [Matrix] class by [createGrid] constructor
  Matrix matrix = Matrix.createGrid();
  /// printing of illustrating message, that implements pseudo UI
  print('Введите допустимую погрешность в интервале (0.1e-7; 1) для будущих корней:');
  /// declaring of [String] variable to access the [extension]
  var str = '';
  /// declaring of future error in equation system
  double? epsilon;
  /// initialize [epsilon] variable until this will be in (0.1e-7; 1) interval
  do{
    /// by default [epsilon] null, because this doesn't
    /// have sound null safety in type [double?]
    if(epsilon != null) {
      /// printing of illustrating message, that implements pseudo UI
      print('Введенная погрешность выходит за заданный интервал, введите другое значение:');
    }
    /// initialize [epsilon] by [extension] on [String]
    epsilon = str.parseStringToFloat(
      onErrorMessage: 'Неверный формат погрешности, '
          'попробуйте ввести другое значение:',
    );
  } while(epsilon <= 0.0000001 || epsilon >= 1);
  /// create an object of [MatrixController] class
  /// by unnamed constructor with passing of [matrix] and [epsilon]
  final matrixController = MatrixController(
    matrix: matrix,
    epsilon: epsilon,
  );
  /// printing of illustrating message, that implements pseudo UI
  print('Введите 0, если хотите найти корни методом Гаусса,\n'
      'или же 1, если методом Зейделя:');
  /// call [parseStringToBoolMethod] by [extension] on [String]
  /// that returns [bool] type
  if(str.parseStringToBool(onErrorMessage: 'Неверный формат, введите 0, '
      'если метод Гаусса, или 1, если метод Зейделя:')) {
    /// create an object of [SeidelController] class
    /// by unnamed constructor with passing of [matrixController]
    SeidelController(
      matrixController: matrixController,
    );
  } else {
    /// create an object of [GaussController] class
    /// by unnamed constructor with passing of [matrixController]
    GaussController(
      matrixController: matrixController,
    );
  }
}
