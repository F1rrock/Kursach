import '../entities/matrix_entity.dart';

abstract class MatrixRepository {
  /// this field associate with [Matrix] class
  final MatrixEntity matrix;

  /// error in answer field
  final double epsilon;

  /// amount of digits after the dot in [double] num
  /// this field set automatically once at initialize part at
  /// [this] constructor
  final int fraction;

  /// print each equal as linear function with each diagonal element
  void printEqualAsLine();

  /// [tryNormalize] function tries to normalize
  /// (absolute value of diagonal element is greater than sum
  /// of each absolute value element in row)
  /// matrix by switching rows
  bool tryNormalize();

  /// [this] function converts given matrix
  /// to upper unary triangle view
  bool convertToTriangleView();

  /// switch rows if this need
  void printAnswers();

  MatrixRepository({
    required this.matrix,
    this.epsilon = 0.00001,
  }) :

  /// get [fraction] by [epsilon] value once
  /// at [this] object has created
        fraction = epsilon
            .toString()

        /// get only part after the dot
        /// in [epsilon] string
            .substring(

          /// get the dot position
          /// in [epsilon] string
          epsilon.toString().indexOf('.'),
        )

        /// get the length of the subbed
        /// [epsilon] string
            .length;
}
