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
  List<dynamic>? appointments;
  final String age;

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
    required this.photo,
    required this.age,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      fullname: json['fullname'],
      Specialization: json['Specialization'],
      phone: json['phone'],
      password: json['password'],
      email: json['email'],
      gender: json['gender'],
      id: json['id'],
      address: json['address'],
      aboutDoctor: json['aboutDoctor'],
      price: json['price'],
      photo: json['photo'],
      age: json['age'],
    );
  }
}
