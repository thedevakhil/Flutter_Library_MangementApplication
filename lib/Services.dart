import 'dart:convert';
import 'package:http/http.dart'
as http; // add the http plugin in pubspec.yaml file.
import 'package:my_library/Teacher/view_all_students_admin.dart';
import 'Student.dart';

class Services {
  static const ROOT = 'http://172.20.10.2/lib/employee_actions.php';//finding the url instructions are provided in the main screen on git ,please find yourcustom path
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';
  static const _LOGIN = 'LOGINALL';
  static const _BOOK = 'BOOK';
  static const _GET_BOOKING ='GETBOOKING';
  static const _ISSUEBOOK ='ISSUE';
  static const _VERIFY_ISSUE='VISSUE';
  static const _VERIFY_ISSUE_B='VISSUEB';
  static const _VERIFY_RETURN='VRETURN';
  static const _VIEW_ISSUED='VIEWISSUE';
  static const _RETURNBOOK='RETURN';
  static const _GET_ALL_BOOKS_ADMIN='GETALLBOOKS';
  static const _VIEW_ALL_BOOKING='ALLBOOKINGS';
  static const _VIEW_ALL_ISSUED_ADMIN='VIEWALLISSUED';
  static const _VIEW_ALL_STUDENTS='VIEWALLSTUDENTS';
  static const _ADD_TEACHER='ADDTEACHER';
  static const _ADD_BOOK='ADDBOOK';
  static const _ADD_STUDENT='ADDSTUDENT';
  // Method to create the table Employees.

  static Future<List<Employee>> getBooks(adno) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      map['adno'] = adno;
      final response = await http.post(ROOT, body: map);
      //print('getEmployees Response: ${response.body}');
      print("ok no error");
      if (200 == response.statusCode) {
        List<Employee> list = parseResponse(response.body);
        return list;
      } else {
        return List<Employee>();
      }
    } catch (e) {
      return List<Employee>(); // return an empty list on exception/error
    }
  }

  static List<Employee> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }
  /////
  // Method to add employee to the database...
  static Future<String> addEmployee(String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(ROOT, body: map);
      print('addEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
  //////view all admin
  static Future<List<Book>> getallbooks() async {

    var map = Map<String, dynamic>();
    map['action'] = _GET_ALL_BOOKS_ADMIN;

    final response = await http.post(ROOT, body: map);
    //var response = await http.post(uri);
    print (response.body);
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Book> listOfFruits = items.map<Book>((json) {
        return Book.fromJson(json);
      }).toList();

      return listOfFruits;
    }
    else {
      throw Exception('Failed to load data.');
    }
  }
  //VIEW ALL STUDENTS FOR ADMIN
  static Future<List<Book>> ViewAllStudent() async {
    var map = Map<String, dynamic>();
    map['action'] = _VIEW_ALL_STUDENTS;

    final response = await http.post(ROOT, body: map);
    //var response = await http.post(uri);
    print (response.body);
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Book> listOfFruits = items.map<Book>((json) {
        return Book.fromJson(json);
      }).toList();

      return listOfFruits;
    }
    else {
      throw Exception('Failed to load data.');
    }
  }
  //view all issued for admin
  static Future<List<Book>> viewallissuedadmin() async {

    var map = Map<String, dynamic>();
    map['action'] = _VIEW_ALL_ISSUED_ADMIN;

    final response = await http.post(ROOT, body: map);
    //var response = await http.post(uri);
    print (response.body);
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Book> listOfFruits = items.map<Book>((json) {
        return Book.fromJson(json);
      }).toList();

      return listOfFruits;
    }
    else {
      throw Exception('Failed to load data.');
    }
  }
//view all booking for admin
  static Future<List<Book>> getallbookings() async {

    var map = Map<String, dynamic>();
    map['action'] = _VIEW_ALL_BOOKING;

    final response = await http.post(ROOT, body: map);
    //var response = await http.post(uri);
    print (response.body);
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Book> listOfFruits = items.map<Book>((json) {
        return Book.fromJson(json);
      }).toList();

      return listOfFruits;
    }
    else {
      throw Exception('Failed to load data.');
    }
  }
////show my booking
  static Future<List<Book>> getbooking(String empId) async {

      var map = Map<String, dynamic>();
      map['action'] = _GET_BOOKING;
      map['emp_id'] = empId;
      final response = await http.post(ROOT, body: map);
      //var response = await http.post(uri);
      print (response.body);
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();

        List<Book> listOfFruits = items.map<Book>((json) {
          return Book.fromJson(json);
        }).toList();

        return listOfFruits;
      }
      else {
        throw Exception('Failed to load data.');
      }
    }
///////////


  static Future<String> book(String empId, String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _BOOK;
      map['studentid'] = firstName;
      map['last_name'] = lastName;
      map['emp_id'] = empId;
      final response = await http.post(ROOT, body: map);
      print('book Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
  //////
  static Future<String> login2(String firstName, String lastName,String type) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _LOGIN;
      map['email'] = firstName;
      map['pass'] = lastName;
      map['type'] = type;
      final response = await http.post(ROOT, body: map);
      print('login Response: ${response.body.trimLeft()}');
      print("function called");
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
  static Future<String> issueBook(String firstName, String b) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ISSUEBOOK;
      map['bino'] = firstName;
      map['adno'] = b;
//return firstName;
      final response = await http.post(ROOT, body: map);
      print('Issue book Response: ${response.body}');
       if (200 == response.statusCode) {
           return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  //Method for adding teacher
  static Future<String> addteacher(String tname, String des, String phn, String email, String pass) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_TEACHER;
      map['tname'] = tname;
      map['des'] = des;
      map['phn'] = phn;
      map['email'] = email;
      map['pass'] = pass;
//return firstName;
      final response = await http.post(ROOT, body: map);
      print('Issue book Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  //add Student
  static Future<String> addstudent(String name, String email, String phn, String batch,String dept, String admno,String gen) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_STUDENT;
      map['name'] = name;
      map['email'] = email;
      map['phn'] = phn;
      map['batch'] = batch;
      map['admno'] = admno;
      map['gen'] = gen;
      map['dept'] = dept;
//return firstName;
      final response = await http.post(ROOT, body: map);
      print('Issue student Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> addbook(String bookname, String author, String rate, String booknum, String edition, String category) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_BOOK;
      map['bookname'] = bookname;
      map['author'] = author;
      map['rate'] = rate;
      map['category'] = category;
      map['edition'] = edition;
      map['booknum'] = booknum;
//return firstName;
      final response = await http.post(ROOT, body: map);
      print('Issue book Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to update an Employee in Database...
  static Future<String> updateEmployee(
      String empId, String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_EMP_ACTION;
      map['emp_id'] = empId;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(ROOT, body: map);
      print('updateEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to Delete an Employee from Database...
  static Future<String> deleteEmployee(String empId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP_ACTION;
      map['emp_id'] = empId;
      final response = await http.post(ROOT, body: map);
      print('deleteEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
  static Future<String> verifyIssue(String bino,String adno) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _VERIFY_ISSUE;
      map['bino'] = bino;
      map['adno']= adno;
      final response = await http.post(ROOT, body: map);
      print('Verify Issued Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
  //issuing the ordered book VISSUEB
  static Future<String> verifyIssueB(String bino,String adno) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _VERIFY_ISSUE_B;
      map['bino'] = bino;
      map['adno']= adno;
      final response = await http.post(ROOT, body: map);
      print('Verify Issued Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
  //method for view issued books
  static Future<List<Book>> viewissued(String empId) async {
    var map = Map<String, dynamic>();
    map['action'] = _VIEW_ISSUED;
    map['emp_id']=empId;
    final response = await http.post(ROOT, body: map);
    //var response = await http.post(uri);
    print (response.body);
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Book> listOfFruits = items.map<Book>((json) {
        return Book.fromJson(json);
      }).toList();

      return listOfFruits;
    }
    else {
      throw Exception('Failed to load data.');
    }
  }
//end view issued
//method for return Boook
  static Future<String> returnBook(String bino) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _RETURNBOOK;
      map['bino'] = bino;
      final response = await http.post(ROOT, body: map);
      print('Return book Response: ${response.body}');

      if (200 == response.statusCode) {

        return response.body;

      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
//Return Book end here
//Verify Return
  static Future<String> verifyReturn(String bino) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _VERIFY_RETURN;
      map['bino'] = bino;

      final response = await http.post(ROOT, body: map);
      print('Verify Return Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
//verify return end here
}
