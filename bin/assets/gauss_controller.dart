import 'matrix_methods_controller.dart';

class GaussController extends MatrixMethodsController {

  @override
  void execute() {
    printGrid(text: 'Исходная матрица, полученная из СЛУ:');
    print('\nПриведем матрицу к треугольному виду.');
    if (!matrixController.convertToTriangleView()) {
      return;
    }
    matrixController.printAnswers();
  }

  GaussController({
    required super.matrixController,
  })  {
    execute();
  }
}