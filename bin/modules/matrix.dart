import 'dart:math';

import '../extensions/string_extension.dart';

abstract class _MatrixProperties {
  final int size;
  final List<List<double>> grid;

  // ignore: constant_identifier_names
  static const NULL_ERROR_MESSAGE = 'Неверно введены данные для этого'
      ' поля, попробуйте ввести его еще раз:';
  // ignore: constant_identifier_names
  static const RANDOM_INT_RANGE = 2000;

  _MatrixProperties.inputGrid({required this.size})
      : grid = List.generate(
          size,
          (column) {
            print('Заполним параметры ${column + 1} уравнения.');
            return List.generate(
              size + 1,
              (row) {
                var text = size <= row
                    ? 'Введите значение '
                        'свободного коэффициента в этом уравнении:'
                    : 'Введите значение коэффициента перед '
                        'неизвестной x${row + 1}:';
                print(text);
                var input = '';
                return input.parseStringToFloat(
                  onErrorMessage: NULL_ERROR_MESSAGE,
                );
              },
              growable: false,
            );
          },
          growable: false,
        );

  _MatrixProperties.randomGrid({required this.size, required Random random})
      : grid = List.generate(
          size,
          (column) => List.generate(
            size + 1,
            (row) => (random.nextDouble()
                + random.nextInt(RANDOM_INT_RANGE))
                * (random.nextBool() ? 1 : -1),
            growable: false,
          ),
          growable: false,
        );
}

class Matrix extends _MatrixProperties {
  // ignore: constant_identifier_names
  static const WELCOME_MESSAGE = 'Введите параметры будущей '
      'системы линейных уравнений.\nДля начала введите кол-во'
      ' неизвестных в системе:';

  Matrix._input({required int size}) :
        super.inputGrid(size: size);

  Matrix._random({required int size})
      : super.randomGrid(size: size, random: Random());

  factory Matrix.createGrid({bool isRandomFilled = false}) {
    print(WELCOME_MESSAGE);
    int size;
    var input = '';
    bool isCorrect;
    do {
      size = input.parseStringToInt(
        onErrorMessage: _MatrixProperties.NULL_ERROR_MESSAGE,
      );
      isCorrect = true;
      if (size < 2) {
        print("некорректное значение "
            "для обозначения количества "
            "неизвестных в системе,\nвведите новое значение "
            "для этого поля:");
        isCorrect = false;
      }
      if (size > 10) {
        print("настоятельно рекомендуется "
            "использовать небольшое "
            "количество неизвестных (меньше 10),\n"
            "введите новое значение:");
        isCorrect = false;
      }
    } while (!isCorrect);
    return isRandomFilled
        ? Matrix._random(size: size)
        : Matrix._input(size: size);
  }
}
