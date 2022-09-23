import '../extensions/list_extension.dart';
import '../modules/matrix_controller.dart';

class MatrixMethodsController {
  final MatrixController matrixController;

  void printGrid({String text = ''}) {
    matrixController.matrix.grid.printGrid(
      message: text,
      fraction: matrixController.fraction,
    );
  }

  void execute() {}

  const MatrixMethodsController({
    required this.matrixController,
  });
}
