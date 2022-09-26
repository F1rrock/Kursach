import 'dart:math';

import '../extensions/string_extension.dart';

/// initialize constant values in this file
///
/// [NULL_ERROR_MESSAGE] is a [String] object, that illustrates
/// every time, that application catches wrong type variable
// ignore: constant_identifier_names
const NULL_ERROR_MESSAGE = 'Неверно введены данные для этого'
    ' поля, попробуйте ввести его еще раз:';

/// [RANDOM_INT_RANGE] is an [int] variable, that causes
/// range of absolute whole part of generated random [double] num
// ignore: constant_identifier_names
const RANDOM_INT_RANGE = 2000;

/// [WELCOME_MESSAGE] is a [String] object, that illustrates
/// one time before creating of a [Matrix] object
// ignore: constant_identifier_names
const WELCOME_MESSAGE = 'Введите параметры будущей '
    'системы линейных уравнений.\nДля начала введите кол-во'
    ' неизвестных в системе:';

/// initialize a file local abstract class with
/// the main properties of [Matrix] class
abstract class _MatrixProperties {
  /// declare variable causes width and height of future square matrix
  final int size;

  /// declare variable causes square matrix of [double] num
  final List<List<double>> grid;

  /// declare of [inputGrid] file local constructor,
  /// where user can input grid by his own
  _MatrixProperties.inputGrid({required this.size})

      /// initialize grid causes square matrix of [double] numbs
      : grid = List.generate(
          /// initialize grid rows
          ///
          /// initialize matrix height
          size,
          (row) {
            /// printing of illustrating message,
            /// that implements pseudo UI
            print('Заполним параметры ${row + 1} уравнения.');
            return List.generate(
              /// initialize grid columns
              ///
              /// initialize matrix width
              size + 1,
              (column) {
                /// initialize a future printed text
                var text = size <= column
                    ? 'Введите значение '
                        'свободного коэффициента в этом уравнении:'
                    : 'Введите значение коэффициента перед '
                        'неизвестной x${column + 1}:';

                /// printing of illustrating message,
                /// that implements pseudo UI
                print(text);

                /// declare [String] object to access [extension]
                var input = '';

                /// initialize [input] by [extension] on [String]
                return input.parseStringToFloat(
                  onErrorMessage: NULL_ERROR_MESSAGE,
                );
              },

              /// make this matrix with constant height
              growable: false,
            );
          },

          /// make this matrix with constant width
          growable: false,
        );

  /// declare of [randomGrid] file local constructor,
  /// where grid will have random value fields
  _MatrixProperties.randomGrid({required this.size, required Random random})

      /// initialize grid causes square matrix of [double] numbs
      : grid = List.generate(
          /// initialize grid rows
          ///
          /// initialize matrix height
          size,
          (column) => List.generate(
            /// initialize matrix width
            size + 1,

            /// fill this field with random [double]
            (row) =>
                (random.nextDouble() + random.nextInt(RANDOM_INT_RANGE)) *
                (random.nextBool() ? 1 : -1),

            /// make this matrix with constant height
            growable: false,
          ),

          /// make this matrix with constant width
          growable: false,
        );
}

/// initialize a class which extends
/// file local [_MatrixProperties]
class Matrix extends _MatrixProperties {
  /// declare of [_input] file local constructor
  Matrix._input({required int size})
      :

        /// call super [_MatrixProperties.inputGrid] constructor
        super.inputGrid(size: size);

  /// declare of [_random] file local constructor
  Matrix._random({required int size})

      /// call super [_MatrixProperties.inputGrid] constructor
      : super.randomGrid(size: size, random: Random());

  /// declare factory constructor [createGrid]
  /// which will be implements pseudo UI
  factory Matrix.createGrid({bool isRandomFilled = false}) {
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
        ? Matrix._random(size: size)
        : Matrix._input(size: size);
  }
}
