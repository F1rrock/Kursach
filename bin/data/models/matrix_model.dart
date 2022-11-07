//####  Модуль matrix
//####  Константы, используемые в модуле:
//####  NULL_ERROR_MESSAGE - сообщение о неверном типе данных;
//####  RANDOM_INT_RANGE - диапазон генераций случайных чисел по модулю;

//####  Основные свойства, используемые в программе:
//####  size - размер матрицы
//####  grid - двумерный массив, хранящий
//####  значения полей матрицы

//####  Подпрограммы модуля:
//####  createGrid - фабричный конструктор, задающий начальные настройки для работы с
//####  модулем;


import 'dart:math';

import '../../core/extensions/string_extension.dart';
import '../../domain/entities/matrix_entity.dart';

/// initialize a class which extends
/// file local [_MatrixProperties]
class MatrixModel extends MatrixEntity {
  /// declare of [_input] file local constructor
  MatrixModel._input({required int size})
      :

        /// call super [_MatrixProperties.inputGrid] constructor
        super.inputGrid(size: size);

  /// declare of [_random] file local constructor
  MatrixModel._random({required int size})

      /// call super [_MatrixProperties.inputGrid] constructor
      : super.randomGrid(size: size, random: Random());

  /// declare factory constructor [createGrid]
  /// which will be implements pseudo UI
  factory MatrixModel.createGrid({bool isRandomFilled = false}) {
    /// printing of illustrating message,
    /// that implements pseudo UI
    print(WELCOME_MESSAGE);

    /// declare future matrix size
    int size;

    /// declaring of [String] variable to access the [extension]
    var input = '';

    /// declare future locking [bool]
    bool isCorrect;

    /// initialize [size] variable until this will be in [2; 10] interval
    do {
      /// initialize [size] by [extension] on [String]
      size = input.parseStringToInt(
        onErrorMessage: NULL_ERROR_MESSAGE,
      );

      /// initialize [isCorrect] as true by default
      /// in every iteration
      isCorrect = true;
      if (size < 2) {
        /// printing of illustrating message,
        /// that implements pseudo UI
        print("некорректное значение "
            "для обозначения количества "
            "неизвестных в системе,\nвведите новое значение "
            "для этого поля:");

        /// change value to false,
        /// to do one more iteration
        isCorrect = false;
      }
      if (size > 10) {
        /// printing of illustrating message,
        /// that implements pseudo UI
        print("настоятельно рекомендуется "
            "использовать небольшое "
            "количество неизвестных (меньше 10),\n"
            "введите новое значение:");

        /// change value to false,
        /// to do one more iteration
        isCorrect = false;
      }
    } while (!isCorrect);

    /// return selected file local constructor
    return isRandomFilled
        ? MatrixModel._random(size: size)
        : MatrixModel._input(size: size);
  }
}
