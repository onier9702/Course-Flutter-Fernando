import 'package:formz/formz.dart';

// Define input validation errors
enum StockError { empty, notNegative }

// Extend FormzInput and provide the input type and error type.
class Stock extends FormzInput<int, StockError> {

  // Call super.pure to represent an unmodified form input.
  const Stock.pure() : super.pure(0);

  // Call super.dirty to represent a modified form input.
  const Stock.dirty( int value ) : super.dirty(value);



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == StockError.empty ) return 'Field is required';
    if ( displayError == StockError.notNegative ) return 'number must be longer than or equal to zero';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  StockError? validator(int value) {
    
    if ( value.toString().isEmpty || value.toString().trim().isEmpty ) return StockError.empty;
    if ( value < 0 ) return StockError.notNegative;

    return null;
  }
}
