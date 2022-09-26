import '../extensions/list_extension.dart';
import '../modules/matrix_controller.dart';

/// declare of [MatrixMethodsController] which associate
/// with [MatrixController] class
class MatrixMethodsController {
  /// associated controller class
  final MatrixController matrixController;
  /// declare of such of basement method
  void printGrid({String text = ''}) {
    /// calls [printGrid] from [Matrix] class
    matrixController.matrix.grid.printGrid(
      message: text,
      fraction: matrixController.fraction,
    );
  }
  /// empty method which will implements
  /// in [GaussController] and [SeidelController] classes
  void execute() {}
  /// declare of constant unnamed constructor
  const MatrixMethodsController({
    required this.matrixController,
  });
}
