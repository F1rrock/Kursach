import 'dart:math';

import '../../core/extensions/list_extension.dart';
import 'core/matrix_case.dart';

/// declare of class, which extends [MatrixCase]
class SeidelCase extends MatrixCase {
  /// declare variable causes square matrix of [String] objects
  final List<List<String>> _answerGrid;

  /// declare variable causes column of [double] num,
  /// which changes fields values in each iteration
  /// of Seidel method
  final List<double> _iterable;

  /// declare file local method which iterate
  /// in table with Seidel method
  void _fillAnswerGrid() {
    /// this variable shows the index of iteration
    var count = 0;

    /// this variable is equal to [Matrix] size
    final n = matrixRepository.matrix.size;

    /// declare variable which causes the max error in iteration
    double maxError;

    /// initialize [element] variable until
    /// this can be parsed to [bool] in (UTF-8)
    do {
      /// declare a row in this table with index of iteration
      /// by default
      final list = <String>[(count + 1).toString()];

      /// initialize max error with default 0 (the most minimum) value
      maxError = 0.0;

      /// initialize a [list] with [iterable] elements
      list.addAll(
        List.generate(
          _iterable.length,
          (index) =>
              _iterable[index].toStringAsFixed(matrixRepository.fraction + 2),
          growable: false,
        ),
      );

      /// implements Seidel method iteration
      for (var i = 0; i < n; i++) {
        /// remember [iterable] in this step
        var y = _iterable[i];

        /// put the [grid] element in [iterable] in this step
        _iterable[i] = matrixRepository.matrix.grid[i][n];

        /// update iterable element
        for (var j = 0; j < n; j++) {
          if (j != i) {
            _iterable[i] -= matrixRepository.matrix.grid[i][j]
                * _iterable[j];
          }
        }

        /// divide iterable element on diagonal
        /// element of grid in [Matrix]
        _iterable[i] /= matrixRepository.matrix.grid[i][i];

        /// initialize error on this step
        var error = (_iterable[i] - y).abs();

        /// this find max error in this iteration
        maxError = max(error, maxError);
      }

      /// add error column to [list] row
      list.add(maxError.toStringAsFixed(matrixRepository.fraction + 2));

      /// put [list] row to [answerGrid]
      _answerGrid.add(list);

      /// increment the index of iteration
      count++;
    } while (maxError > matrixRepository.epsilon);
  }

  /// override and implement method
  @override
  void execute() {
    /// printing default grid from [Matrix]
    printGrid(text: 'Исходная матрица, полученная из СЛАУ:');

    /// printing of illustrating message,
    /// that implements pseudo UI
    print('\nПриведем матрицу к сходящейся методом перестановок строк.');

    /// [tryNormalize] method returns true,
    /// if each absolute diagonal element will be
    /// greater than sum of any absolute element
    /// in row in the modified matrix
    if (!matrixRepository.tryNormalize()) {
      /// printing of illustrating message,
      /// that implements pseudo UI
      print('К сожалению, данный метод не дал результатов,\n'
          'следовательно матрица не будет сходиться и '
          'дальнейшие расчеты бессымслены... :(');

      /// exit from [this] function
      return;
    }

    /// printing default grid from [Matrix]
    printGrid(text: 'Приведенная к сходящимуся виду матрица:');

    /// printing of illustrating message,
    /// that implements pseudo UI
    print('\nвыразим неизвестные из уравнений:');

    /// call [printEqualAsLine] method from [MatrixController] class
    matrixRepository.printEqualAsLine();

    /// call [this] file local function
    _fillAnswerGrid();

    /// printing [this] answer grid from [Matrix]
    _answerGrid.printGrid(message: 'Вычисляем корни:');

    /// offset line in console terminal for
    /// make the pseudo UI more readable
    print('');

    /// print each answer on given system equation
    for (var i = 0; i < matrixRepository.matrix.size; i++) {
      /// printing of illustrating message,
      /// that implements pseudo UI
      print(
          'x${i + 1} = ${_iterable[i]
              .toStringAsFixed(matrixRepository.fraction)}');
    }
  }

  /// declare of unnamed constructor
  SeidelCase({
    required super.matrixRepository,
  })  : _answerGrid = List.generate(
          /// generate title row with [answerGrid] initialization
          1,
          (index) {
            /// the name of the first column will be {k} by default
            /// {k} is the index of the iteration
            final list = <String>['k'];

            /// iterate each {x} with index to print {x}
            /// cols in title row
            for (var i = 0; i < matrixRepository.matrix.size; i++) {
              list.add('x${i + 1}');
            }

            /// add {e max} - error column to title row
            list.add('e max');

            /// return list, as not growable
            return List.of(
              list,
              growable: false,
            );
          },

          /// set [answerGrid] as growable [List]
          growable: true,
        ),

        /// initialize future iterated row in [answerGrid]
        _iterable = List.filled(
          matrixRepository.matrix.size,

          /// by default [iterable] list
          /// filled with zero elements
          0,

          /// set [iterable] as not growable [List]
          growable: false,
        );
}
