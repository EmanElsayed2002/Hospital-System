import 'package:hospital/models/Patient.dart';

class Appointment{
  final Patient patient ;
  final String date; 
  final String time ;
  

  Appointment({required this.patient , required this.date , required this.time});
}
