// Purpose: Patient model

class Patient {
  final String email;
  final String password;
  final String fullname;
  final String age;
  final String photo;
  final String gender;
  final String phone;
  final String id;
  final dynamic appointments;

  Patient({
    required this.email,
    required this.password,
    required this.fullname,
    required this.age,
    required this.photo,
    required this.gender,
    required this.phone,
    required this.id,
    required this.appointments,
  });
}
