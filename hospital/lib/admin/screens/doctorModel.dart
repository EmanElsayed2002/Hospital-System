// the doctor model class
class Doctor {
  final String fullname;
  final String Specialization;
  final String phone;
  final String password;
  final String email;
  final String gender;
  late String photo;
  final String id;
  final String address;
  final String aboutDoctor;
  final String price;

  Doctor({
    required this.fullname,
    required this.Specialization,
    required this.phone,
    required this.password,
    required this.email,
    required this.gender,
    required this.id,
    required this.address,
    required this.aboutDoctor,
    required this.price,
  });
}