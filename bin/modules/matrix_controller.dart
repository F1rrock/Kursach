import '../extensions/list_extension.dart';
import 'matrix.dart';

class MatrixController {
  final Matrix matrix;
  final double epsilon;
  final int fraction;

  final List<double> xx;

  String _toStringWithSign(double num) {
    return num >= 0
        ? '+${num.toStringAsFixed(fraction)}'
        : num.toStringAsFixed(fraction);
  }

  void printEqualAsLine() {
    for (var i = 0; i < matrix.size; i++) {
      var rightSideString =
          '${(1 / matrix.grid[i][i]).toStringAsFixed(fraction)}'
          '*(${matrix.grid[i][matrix.size].toStringAsFixed(fraction)}';
      for (var j = 0; j < matrix.size; j++) {
        if (i != j) {
          rightSideString +=
          '${_toStringWithSign(-matrix.grid[i][j])}*x${j + 1}';
        }
      }
      print('x${i + 1} = $rightSideString)');
    }
  }

  bool tryNormalize() {
    for (var k = 0; k < matrix.size; k++) {
      var index = -1;
      for (var i = k; i < matrix.size; i++) {
        var absSum = 0.0;
        for (var j = 0; j < matrix.size; j++) {
          if (k != j) {
            absSum += matrix.grid[i][j].abs();
          }
        }
        if (matrix.grid[i][k].abs() > absSum) {
          index = i;
        }
      }
      if (index < 0) {
        return false;
      }
      if (index != k) {
        var temp = matrix.grid[index];
        matrix.grid[index] = matrix.grid[k];
        matrix.grid[k] = temp;
      }
    }
    return true;
  }

  bool convertToTriangleView() {
    for (var k = 0; k < matrix.size; k++) {
      var max = matrix.grid[k][k].abs();
      var index = k;

      /// find row with max element in k column
      for (var i = k + 1; i < matrix.size; i++) {
        if (matrix.grid[i][k].abs() > max) {
          max = matrix.grid[i][k].abs();
          index = i;
        }
      }

      /// replace rows
      if (max < epsilon) {
        /// no zero diagonal elements
        print('\nНельзя получить точное решение '
            'данной системы т.к. '
            'невозможно точно определить корень x${index + 1}\n');
        return false;
      }

      /// check if we need replace strings
      if (k != index) {
        var temp = matrix.grid[k];
        matrix.grid[k] = matrix.grid[index];
        matrix.grid[index] = temp;
        matrix.grid.printGrid(
          message: 'поменяем строки '
              '${k + 1} и ${index + 1} местами',
          fraction: fraction,
        );
      }

      /// do normal equality
      for (var i = k; i < matrix.size; i++) {
        var temp = matrix.grid[i][k];

        /// for zero coefficient
        if (temp.abs() < epsilon) {
          continue;
        }
        if (temp != 1) {
          for (var j = k; j < matrix.size + 1; j++) {
            matrix.grid[i][j] /= temp;
          }
          matrix.grid.printGrid(
            message: 'поделим ${i + 1}-ую строку '
                'на ${temp.toStringAsFixed(fraction)}',
            fraction: fraction,
          );
        }

        /// equality don't sub self
        if (i == k) {
          continue;
        }
        for (var j = k; j < matrix.size + 1; j++) {
          matrix.grid[i][j] -= matrix.grid[k][j];
        }
        matrix.grid.printGrid(
          message: 'вычтем ${k + 1}-ую строку '
              'из ${i + 1}-${i == 2 ? 'ей' : 'ой'}',
          fraction: fraction,
        );
      }
    }
    return true;
  }

  void printAnswers() {
    /// fill answer row
    xx[matrix.size - 1] = matrix.grid[matrix.size - 1][matrix.size];
    for (var i = matrix.size - 2; i >= 0; i--) {
      xx[i] = matrix.grid[i][matrix.size];
      for (var j = i + 1; j < matrix.size; j++) {
        xx[i] -= matrix.grid[i][j] * xx[j];
      }
    }

    /// print answers
    print('\nКорни системы:');
    var i = 0;
    for (var x in xx) {
      i++;
      print('x$i = ${x.toStringAsFixed(fraction)}');
    }
  }

  MatrixController({
    required this.matrix,
    this.epsilon = 0.00001,
  })
      : xx = List.filled(
    matrix.size,
    0,
  ),
        fraction = epsilon
            .toString()
            .substring(
          epsilon.toString().indexOf('.'),
        )
            .length;
}
