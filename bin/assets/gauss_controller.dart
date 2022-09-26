import 'matrix_methods_controller.dart';

/// declare of class, which extends [MatrixMethodsController]
class GaussController extends MatrixMethodsController {
  /// override and implement method
  @override
  void execute() {
    /// printing default grid from [Matrix]
    printGrid(text: 'Исходная матрица, полученная из СЛУ:');

    /// printing of illustrating message,
    /// that implements pseudo UI
    print('\nПриведем матрицу к треугольному виду.');

    /// try to convert to upper triangle view
    /// if one of diagonal element is 0, this method returns [false]
    /// and [true] by default
    if (!matrixController.convertToTriangleView()) {
      /// exit from [this] function
      return;
    }

    /// print and calculate answer column
    matrixController.printAnswers();
  }

  /// declare of unnamed constructor
  GaussController({
    required super.matrixController,
  }) {
    /// calls [execute] function by default
    /// after [this] object has created
    execute();
  }
}
