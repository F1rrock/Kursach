import 'core/matrix_case.dart';

/// declare of class, which extends [MatrixCase]
class GaussCase extends MatrixCase {
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
    if (!matrixRepository.convertToTriangleView()) {
      /// exit from [this] function
      return;
    }

    /// print and calculate answer column
    matrixRepository.printAnswers();
  }

  /// declare of unnamed constructor
  const GaussCase({
    required super.matrixRepository,
  });
}
