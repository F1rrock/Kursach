//####  Программа kursach_dart

//####  Курсовой проект
//####  по предмету МДК 01.01  Разработка программных модулей

//####  по теме "Разработка программы нахождения корней СЛАУ"
//####  Язык: Dart
//####  Разработал: Куртаметов Э.Р.

//####  Задание:
//####  Разработка программы нахождения корней СЛАУ:
//####  1) методом Жордана-Гаусса;
//####  2) методом Гаусса-Зейделя.

//####  Основные переменные, используемые в программе:
//####  matrix - экземпляр объекта класса Matrix
//####  epsilon - переменная, хранящая значение погрешности корней
//####  matrixController - объект, управления состоянием исходной матрицы;
//####  concreteMethod - экземпляр класса MatrixMethodsController, где с помощью подстановки
//####  Барбары Лисков будет вызываться нужный метод решения

//####  Вызываемые методы:
//####  createGrid - фабричный конструктор класса MatrixMethods;
//####  parseStringToFloat - процедура перевода введенного числа
//####  в тип данных float;
//####  execute - функция вызова алгоритма нужного метода;




import 'core/extensions/string_extension.dart';
import 'data/models/matrix_model.dart';
import 'data/repositories/matrix_repository.dart';
import 'domain/entities/matrix_entity.dart';
import 'domain/repositories/matrix_repository.dart';
import 'domain/use_cases/core/matrix_case.dart';
import 'domain/use_cases/gauss_case.dart';
import 'domain/use_cases/seidel_case.dart';

/// application runs here
void main() {
  /// create an object of [Matrix] class by [createGrid] constructor
  MatrixEntity matrix = MatrixModel.createGrid();

  /// printing of illustrating message, that implements pseudo UI
  print(
      'Введите допустимую погрешность в интервале (0.1e-7; 1) для будущих корней:');

  /// declaring of [String] variable to access the [extension]
  var str = '';

  /// declaring of future error in equation system
  double? epsilon;

  /// initialize [epsilon] variable until this will be in (0.1e-7; 1) interval
  do {
    /// by default [epsilon] null, because this doesn't
    /// have sound null safety in type [double?]
    if (epsilon != null) {
      /// printing of illustrating message, that implements pseudo UI
      print(
          'Введенная погрешность выходит за заданный интервал, введите другое значение:');
    }

    /// initialize [epsilon] by [extension] on [String]
    epsilon = str.parseStringToFloat(
      onErrorMessage: 'Неверный формат погрешности, '
          'попробуйте ввести другое значение:',
    );
  } while (epsilon <= 0.1e-7 || epsilon >= 1);

  /// create an object of [MatrixController] class
  /// by unnamed constructor with passing of [matrix] and [epsilon]
  final MatrixRepository matrixRepository = MatrixMethodsRepository(
    matrix: matrix,
    epsilon: epsilon,
  );

  /// printing of illustrating message, that implements pseudo UI
  print('Введите 0, если хотите найти корни методом Гаусса,\n'
      'или же 1, если методом Зейделя:');

  /// call [parseStringToBoolMethod] by [extension] on [String]
  /// that returns [bool] type
  MatrixCase concreteMethod;
  if (str.parseStringToBool(
      onErrorMessage: 'Неверный формат, введите 0, '
          'если метод Гаусса, или 1, если метод Зейделя:')) {
    /// create an object of [SeidelController] class
    /// by unnamed constructor with passing of [matrixController]
    concreteMethod = SeidelCase(
      matrixRepository: matrixRepository,
    );
  } else {
    /// create an object of [GaussController] class
    /// by unnamed constructor with passing of [matrixController]
    concreteMethod = GaussCase(
      matrixRepository: matrixRepository,
    );
  }
  /// use this like strategy pattern
  concreteMethod.execute();
}
