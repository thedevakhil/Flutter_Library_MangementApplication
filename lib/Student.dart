class Employee {
  String id;
  String title;
  String author;
  String edition;
  String bino;

  Employee({this.id, this.title, this.author, this.edition, this.bino});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      edition: json['edition'] as String,
      bino: json['bino'] as String,
    );
  }
}

class Book {
  String id;
  String firstName;
  String lastName;
  String noc;
String bino;
String isd;
String edition;
String rate;
String category;
String status;
String name;
String adno;
String dept;
String gender;
String batch;

  Book({this.id, this.firstName, this.lastName, this.noc, this.bino, this.isd, this.edition, this.category, this.rate, this.status, this.name, this.adno, this.dept, this.batch, this.gender});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['Booking_id'] as String,
      firstName: json['title'] as String,
      lastName: json['author'] as String,
      noc: json['bdate'] as String,
      bino: json['bino'] as String,
      isd: json['issuedate'] as String,
      edition: json['edition'] as String,
      category: json['category'] as String,
      rate: json['rate'] as String,
      status: json['status'] as String,
      adno:json['adno'] as String,
      name: json['name'] as String,
      dept: json['dept'] as String,
      gender: json['gen'] as String,
      batch: json['bach'] as String,
    );
  }
}
class Student {
  String id;
  String adno;
  String name;
  String dept;
  String batch;
  String isd;
  String edition;
  String rate;
  String category;
  String status;


  Student({this.id, this.adno, this.name, this.dept, this.batch, this.isd, this.edition, this.category, this.rate, this.status});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as String,
      adno: json['adno'] as String,
      name: json['name'] as String,
      dept: json['dept'] as String,
      batch: json['bach'] as String,
      isd: json['issuedate'] as String,
      edition: json['edition'] as String,
      category: json['category'] as String,
      rate: json['rate'] as String,
      status: json['status'] as String,

    );
  }
}