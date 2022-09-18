import '../main.dart';
import '../modules/matrix.dart';

class GaussController {
  final Matrix matrix;
  final epsilon = 0.000001;
  final List<List<double>> grid;
  final List<double> _xx;

  void convertToTriangleView() {
    double tmp;

    for (var i = 0; i < matrix.size; i++) {
      tmp = grid[i][i];
      for (var j = matrix.size; j >= i; j--) {
        grid[i][j] /= tmp;
      }
      for (var j = i + 1; j < matrix.size; j++) {
        tmp = grid[j][i];
        for (var k = matrix.size; k >= i; k--) {
          grid[j][k] -= tmp * grid[i][k];
        }
      }
    }
  }

  void _getResult() {
    _xx[matrix.size - 1] = grid[matrix.size - 1][matrix.size];
    for(var i = matrix.size - 2; i >= 0; i --) {
      _xx[i] = grid[i][matrix.size];
      for(var j = i + 1; j < matrix.size; j ++) {
        _xx[i] -= grid[i][j] * _xx[j];
      }
    }
  }

  void printResult() {
    var i = 0;
    _getResult();
    for(var x in _xx) {
      i ++;
      print('x$i = ${x.toStringAsFixed(Epsilon.NUM_FRACTION)}');
    }
  }

  GaussController({
    required this.matrix,
  })  : grid = matrix.grid,
        _xx = List.filled(
          matrix.size,
          0,
        );
}
