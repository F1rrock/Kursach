import '../extensions/list_extension.dart';
import '../modules/matrix_controller.dart';

class MatrixMethodsController {
  final MatrixController matrixController;

  void executeGauss() {
    matrixController.matrix.grid.printGrid(
      message: 'Исходная матрица, полученная из СЛУ:',
      fraction: matrixController.fraction,
    );
    print('Приведем матрицу к треугольному виду.');
    if(!matrixController.convertToTriangleView()) {
      return;
    }
    matrixController.printAnswers();
  }
  
  void executeSeidel() {
    matrixController.matrix.grid.printGrid(
      message: 'Исходная матрица, полученная из СЛУ:',
      fraction: matrixController.fraction,
    );
    print('Нормализуем матрицу.');
  }

  const MatrixMethodsController({
    required this.matrixController,
  });
}
