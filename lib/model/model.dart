class Student {
  final int? id;
  final String name;
  final String age;
  final String phone;
  final String mail; 
  final String? image ;

  Student({
    this.id,
    required this.name,
    required this.age,
    required this.phone,
    required this.mail,
    this.image,
  });

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      phone: map['phone'],
      mail: map['mail'],
      image: map['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'phone': phone,
      'mail': mail,
      'image': image,
    };
  }
}
