//####  Модуль matrix_repository

//####  Основные свойства, используемые в программе:
//####  size - размер матрицы
//####  grid - двумерный массив, хранящий
//####  значения полей матрицы

//####  Подпрограммы модуля:
//####  createGrid - фабричный конструктор, задающий начальные настройки для работы с
//####  модулем;

import '../../core/extensions/list_extension.dart';
import '../../domain/entities/matrix_entity.dart';
import '../../domain/repositories/matrix_repository.dart';

/// initialize a public class which associate with [Matrix] class
class MatrixMethodsRepository extends MatrixRepository {

  /// answer column of [double], here will be answers
  /// on the given equation system
  final List<double> xx;

  /// declare of file local method, which convert [num] to [String]
  /// with plus and minus sign before
  String _toStringWithSign(double num) {
    return num >= 0
        ? '+${num.toStringAsFixed(fraction)}'
        : num.toStringAsFixed(fraction);
  }

  @override
  void printEqualAsLine() {
    for (var i = 0; i < matrix.size; i++) {
      /// generate right side of the equation
      var rightSideString =
          '${(1 / matrix.grid[i][i]).toStringAsFixed(fraction)}'
          '*(${matrix.grid[i][matrix.size].toStringAsFixed(fraction)}';

      /// add all the rest answers to right side of equation
      for (var j = 0; j < matrix.size; j++) {
        if (i != j) {
          rightSideString +=
              '${_toStringWithSign(-matrix.grid[i][j])}*x${j + 1}';
        }
      }

      /// print all equation on each diagonal element
      print('x${i + 1} = $rightSideString)');
    }
  }

  @override
  bool tryNormalize() {
    for (var k = 0; k < matrix.size; k++) {
      /// set index to invalid value in each iteration
      var index = -1;
      for (var i = k; i < matrix.size; i++) {
        /// declare of absolute sum
        var absSum = 0.0;
        for (var j = 0; j < matrix.size; j++) {
          /// add each absolute element without diagonal elem
          if (k != j) {
            absSum += matrix.grid[i][j].abs();
          }
        }
        if (matrix.grid[i][k].abs() > absSum) {
          /// set [index] to normal row for this index of iteration
          index = i;
        }
      }

      /// [this] function will return false if normality
      /// row for this iteration not found
      if (index < 0) {
        return false;
      }

      /// switch rows if this need
      if (index != k) {
        var temp = matrix.grid[index];
        matrix.grid[index] = matrix.grid[k];
        matrix.grid[k] = temp;
      }
    }

    /// return true if given matrix modified
    /// to matrix where normality < q < 1; q in (0; 1)
    return true;
  }

  @override
  bool convertToTriangleView() {
    for (var k = 0; k < matrix.size; k++) {
      /// declare of max absolute element in each column
      /// to avoid [DivideByZeroException], because all zero elements
      /// will be in the bottom of the matrix
      var max = matrix.grid[k][k].abs();

      /// declare index of row that had
      /// max absolute element in column
      var index = k;

      /// find row with max element in [k] column
      for (var i = k + 1; i < matrix.size; i++) {
        if (matrix.grid[i][k].abs() > max) {
          max = matrix.grid[i][k].abs();
          index = i;
        }
      }

      /// switch rows between elem and [max]
      if (max < epsilon / 100) {
        /// [max] element is zero,
        /// therefore diagonal element is equal to zero
        /// and accurate answer never be given
        print('\nНельзя получить точное решение '
            'данной системы т.к. '
            'невозможно точно определить корень x${index + 1}\n');

        /// return false, because accurate answer never be given
        return false;
      }

      if (k != index) {
        var temp = matrix.grid[k];
        matrix.grid[k] = matrix.grid[index];
        matrix.grid[index] = temp;

        /// print matrix with message, that implements
        /// pseudo UI
        matrix.grid.printGrid(
          message: 'поменяем строки '
              '${k + 1} и ${index + 1} местами',
          fraction: fraction,
        );
      }

      /// do normal equality
      for (var i = k; i < matrix.size; i++) {
        /// get divide coefficient in iterated row
        var temp = matrix.grid[i][k];

        /// if divide by zero continue loop
        if (temp.abs() < epsilon) {
          continue;
        }

        /// if [temp] coefficient is {1},
        /// then skip the division of the rows
        if (temp != 1) {
          for (var j = k; j < matrix.size + 1; j++) {
            /// divide iterated row on the [temp] coefficient
            matrix.grid[i][j] /= temp;
          }

          /// print matrix with message, that implements
          /// pseudo UI
          matrix.grid.printGrid(
            message: 'поделим ${i + 1}-ую строку '
                'на ${temp.toStringAsFixed(fraction)}',
            fraction: fraction,
          );
        }

        /// continue loop if row tries sub self
        if (i == k) {
          continue;
        }
        for (var j = k; j < matrix.size + 1; j++) {
          /// sub rows to zeroing rows
          matrix.grid[i][j] -= matrix.grid[k][j];
        }

        /// print matrix with message, that implements
        /// pseudo UI
        matrix.grid.printGrid(
          message: 'вычтем ${k + 1}-ую строку '
              'из ${i + 1}-${i == 2 ? 'ей' : 'ой'}',
          fraction: fraction,
        );
      }
    }

    /// return true, if matrix has been successfully converted
    return true;
  }

  /// this function find answers and push it to answer column
  /// then print answers
  @override
  void printAnswers() {
    /// put the last element of matrix to answer column
    xx[matrix.size - 1] = matrix.grid[matrix.size - 1][matrix.size];
    for (var i = matrix.size - 2; i >= 0; i--) {
      /// declare answer column [i]
      xx[i] = matrix.grid[i][matrix.size];
      for (var j = i + 1; j < matrix.size; j++) {
        /// get truly value of answer column [i]
        xx[i] -= matrix.grid[i][j] * xx[j];
      }
    }

    /// print message to console, this
    /// implements pseudo UI
    print('\nКорни системы:');

    /// declare index of answer
    var i = 0;

    /// fetch the answer column
    for (var x in xx) {
      /// increment answer's index
      i++;

      /// print answer as special message
      /// to console, this implements pseudo UI
      print('x$i = ${x.toStringAsFixed(fraction)}');
    }
  }

  /// declare of unnamed constructor
  MatrixMethodsRepository({
    required MatrixEntity matrix,
    double epsilon = 0.00001,
  })  : xx = List.filled(
          /// fill answer column with zero
          /// fields as default values
          matrix.size,
          0,
        ),
        super(
          matrix: matrix,
          epsilon: epsilon,
        );

}
