import '../../../core/extensions/list_extension.dart';
import '../../repositories/matrix_repository.dart';

/// declare of [MatrixCase] which associate
/// with [MatrixRepository] class
abstract class MatrixCase {
  /// associated controller class
  final MatrixRepository matrixRepository;

  /// declare of such of basement method
  void printGrid({String text = ''}) {
    /// calls [printGrid] from [Matrix] class
    matrixRepository.matrix.grid.printGrid(
      message: text,
      fraction: matrixRepository.fraction,
    );
  }

  /// empty method which will implements
  /// in [GaussController] and [SeidelController] classes
  void execute();

  /// declare of constant unnamed constructor
  const MatrixCase({
    required this.matrixRepository,
  });
}
