/// {@template validator_error}
/// [ValidatorError] is interface for different other validator errors
/// {@endtemplate}
abstract class ValidatorError {
  /// {@macro validator_error}
  const ValidatorError(this.label);

  /// Label of validator to display for user
  final String label;
}
