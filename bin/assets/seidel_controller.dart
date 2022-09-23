import 'dart:math';

import '../extensions/list_extension.dart';
import 'matrix_methods_controller.dart';

class SeidelController extends MatrixMethodsController {
  final List<List<String>> answerGrid;
  final List<double> iterable;

  void _fillAnswerGrid() {
    var count = 0;
    final n = matrixController.matrix.size;
    double maxError;
    do {
      final list = <String>[(count + 1).toString()];
      maxError = 0.0;
      list.addAll(
        List.generate(
          iterable.length,
          (index) =>
              iterable[index].toStringAsFixed(matrixController.fraction + 2),
          growable: false,
        ),
      );
      for (var i = 0; i < n; i++) {
        var y = iterable[i];
        iterable[i] = matrixController.matrix.grid[i][n];
        for (var j = 0; j < n; j++) {
          if (j != i) {
            iterable[i] -= matrixController.matrix.grid[i][j] * iterable[j];
          }
        }
        iterable[i] /= matrixController.matrix.grid[i][i];
        var error = (iterable[i] - y).abs();
        maxError = max(error, maxError);
      }
      list.add(maxError.toStringAsFixed(matrixController.fraction + 2));
      answerGrid.add(list);
      count++;
    } while (maxError > matrixController.epsilon);
  }

  @override
  void execute() {
    printGrid(text: 'Исходная матрица, полученная из СЛАУ:');
    print('\nПриведем матрицу к сходящейся методом перестановок строк.');
    if (!matrixController.tryNormalize()) {
      print('К сожалению, данный метод не дал результатов,\n'
          'следовательно матрица не будет сходиться и '
          'дальнейшие расчеты бессымслены... :(');
      return;
    }
    printGrid(text: 'Приведенная к сходящимуся виду матрица:');
    print('\nвыразим неизвестные из уравнений:');
    matrixController.printEqualAsLine();
    _fillAnswerGrid();
    answerGrid.printGrid(message: 'Вычисляем корни:');
    print('');
    for(var i = 0; i < matrixController.matrix.size; i ++) {
      print('x${i + 1} = ${iterable[i].toStringAsFixed(matrixController.fraction)}');
    }
  }

  SeidelController({
    required super.matrixController,
  })  : answerGrid = List.generate(
          1,
          (index) {
            final list = <String>['k'];
            for (var i = 0; i < matrixController.matrix.size; i++) {
              list.add('x${i + 1}');
            }
            list.add('e max');
            return List.of(
              list,
              growable: false,
            );
          },
          growable: true,
        ),
        iterable = List.filled(
          matrixController.matrix.size,
          0,
          growable: true,
        ) {
    execute();
  }
}
