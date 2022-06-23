import 'dart:math';

class TruncateDoubles {

  double truncateToDecimalPlaces(num value, int fractionalDigits) => (value * pow(10, 
   fractionalDigits)).truncate() / pow(10, fractionalDigits);

}